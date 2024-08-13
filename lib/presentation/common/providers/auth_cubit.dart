import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realmbank_mobile/data/enums/login_type.dart';
import 'package:realmbank_mobile/data/repositories/authentication_repository.dart';
import 'package:realmbank_mobile/presentation/common/providers/auth_cubit.dart';
import 'package:realmbank_mobile/presentation/common/providers/user_cubit.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required this.context,
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(InitialAuthState());

  BuildContext context;
  final AuthenticationRepository _authenticationRepository;
  StreamSubscription? _authStateChangesSubscription;

  Future<void> init() async {
    await _authStateChangesSubscription?.cancel();
    _authStateChangesSubscription =
        _authenticationRepository.authStateChanges.listen(
      (event) {
        if (event == null) {
          emit(InitialAuthState());
        } else {
          emit(SuccessAuthState(user: event));
          context.read<UserCubit>().connectUser();
        }
      },
    );
  }

  Future<void> signIn({
    required LoginType loginType,
    required bool isSignUp,
    String? email,
    String? password,
  }) async {
    try {
      emit(LoadingAuthState());
      final resp = isSignUp
          ? await _authenticationRepository.signUp(
              loginType: loginType,
              email: email,
              password: password,
            )
          : await _authenticationRepository.signIn(
              loginType: loginType,
              email: email,
              password: password,
            ) as UserCredential;

      if (resp == null) {
        throw Exception('Response is null');
      }
      emit(
        SuccessAuthState(user: resp.user!),
      );
      context.read<UserCubit>().connectUser();
    } catch (e) {
      log('AuthCubit.signIn: Error $e');
      emit(FailedAuthState(e.toString()));
    }
  }

  Future<void> signOut() async {
    try {
      emit(LoadingAuthState());
      await _authenticationRepository.signOut();
    } catch (e) {
      log('AuthCubit.signOut: Error: $e');
      emit(FailedAuthState(e.toString()));
    }
  }
}

abstract class AuthState {}

class InitialAuthState extends AuthState {}

class LoadingAuthState extends AuthState {}

class SuccessAuthState extends AuthState {
  SuccessAuthState({required this.user});

  final User user;
}

class FailedAuthState extends AuthState {
  FailedAuthState(this.message);

  final String message;
}
