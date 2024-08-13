import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realmbank_mobile/data/models/user.dart';
import 'package:realmbank_mobile/data/repositories/user_repository.dart';
import 'package:realmbank_mobile/presentation/common/providers/auth_cubit.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({required this.userRepository}) : super(InitialUserState());

  final UserRepository userRepository;

  Future<void> connectUser() async {
    log('happened');
    final String? uid = FirebaseAuth.instance.currentUser?.uid;
    try {
      if (uid == null) {
        return;
      }
      emit(LoadingUserState());
      final user = await userRepository.getUser(uid: uid);
      if (user == null) {
        emit(InitialUserState());
        return;
      }
      emit(
        SuccessUserState(user: user),
      );
    } catch (e) {
      log('UserCubit.init: Error: $e');
      emit(FailedUserState(e.toString()));
    }
  }
}

abstract class UserState {}

class InitialUserState extends UserState {}

class LoadingUserState extends UserState {}

class SuccessUserState extends UserState {
  SuccessUserState({
    required this.user,
  });
  final RMUser user;
}

class FailedUserState extends UserState {
  FailedUserState(this.message);

  final String message;
}
