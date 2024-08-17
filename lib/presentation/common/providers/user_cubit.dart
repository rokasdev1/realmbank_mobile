import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realmbank_mobile/data/models/transaction.dart';
import 'package:realmbank_mobile/data/models/user.dart';
import 'package:realmbank_mobile/data/repositories/user_repository.dart';
import 'package:realmbank_mobile/presentation/common/providers/transaction_cubit.dart';
import 'package:realmbank_mobile/presentation/common/utils/card_number_generator.dart';
import 'package:realmbank_mobile/presentation/common/utils/full_name.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({required this.transactionCubit, required this.userRepository})
      : super(InitialUserState());

  final TransactionCubit transactionCubit;
  final UserRepository userRepository;
  StreamSubscription? userStateChanges;

  Future<void> connectUser() async {
    userStateChanges?.cancel();
    final String? uid = FirebaseAuth.instance.currentUser?.uid;
    try {
      emit(LoadingUserState());
      if (uid == null) {
        return;
      }
      userStateChanges = userRepository.userStateChanges(uid).listen(
        (event) {
          final userDoc = event.data();
          if (userDoc == null) {
            emit(IntroUserState());
            return;
          }
          emit(
            SuccessUserState(
              user: RMUser.fromJson(userDoc),
            ),
          );
        },
      );
      transactionCubit.getTransactions();
    } catch (e) {
      log('UserCubit.init: Error: $e');
      emit(FailedUserState(e.toString()));
    }
  }

  Future<void> createUserAccount({
    required String name,
    required String lastName,
  }) async {
    try {
      emit(LoadingUserState());
      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser == null) {
        emit(InitialUserState());
        return;
      }

      final newUser = RMUser(
        name: name,
        lastName: lastName,
        balance: 0,
        email: currentUser.email ?? '',
        cardNumber: generateCardNumber(currentUser.email ?? ''),
        uid: currentUser.uid,
      );
      await userRepository.createUser(newUser);
      emit(SuccessUserState(user: newUser));
    } catch (e) {
      emit(FailedUserState(e.toString()));
      log('UserCubit.createUserAccount: Error: $e');
    }
    log(state.toString());
  }
}

abstract class UserState {}

class InitialUserState extends UserState {}

class LoadingUserState extends UserState {}

class IntroUserState extends UserState {}

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
