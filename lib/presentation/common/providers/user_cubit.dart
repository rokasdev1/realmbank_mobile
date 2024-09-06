import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realmbank_mobile/data/enums/toast_type.dart';
import 'package:realmbank_mobile/data/models/user.dart';
import 'package:realmbank_mobile/data/repositories/user_repository.dart';
import 'package:realmbank_mobile/presentation/common/providers/request_cubit.dart';
import 'package:realmbank_mobile/presentation/common/providers/transaction_cubit.dart';
import 'package:realmbank_mobile/presentation/common/utils/generate.dart';
import 'package:realmbank_mobile/presentation/common/utils/message_toaster.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(
      {required this.transactionCubit,
      required this.userRepository,
      required this.requestCubit})
      : super(InitialUserState());

  final TransactionCubit transactionCubit;
  final RequestCubit requestCubit;
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
      requestCubit.getReceivedRequests();
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
        cardNumber: Generate.cardNumber(currentUser.email ?? ''),
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

  // read users
  Future<List<RMUser>> getUsers() async {
    try {
      final usersSnapshot =
          await FirebaseFirestore.instance.collection('users').get();
      final users =
          usersSnapshot.docs.map((doc) => RMUser.fromJson(doc.data())).toList();
      return users;
    } catch (e) {
      log('UserCubit.getUsers: Error: $e');
      return [];
    }
  }

  Future<void> updateUser(RMUser user) async {
    try {
      emit(LoadingUserState());
      await userRepository.updateUser(user);
      emit(SuccessUserState(user: user));
      MessageToaster.showMessage(
        message: 'Account successfully updated',
        toastType: ToastType.success,
      );
    } catch (e) {
      emit(FailedUserState(e.toString()));
      log('UserCubit.updateUser: Error: $e');
    }
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
