import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realmbank_mobile/data/models/transaction.dart';
import 'package:realmbank_mobile/data/models/user.dart';
import 'package:realmbank_mobile/data/repositories/user_repository.dart';
import 'package:realmbank_mobile/presentation/common/utils/card_number_generator.dart';
import 'package:realmbank_mobile/presentation/common/utils/full_name.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({required this.userRepository}) : super(InitialUserState());

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

  Future<void> sendMoney(
      RMUser sender, RMUser receiver, double amount, String description) async {
    final newSenderBalance =
        double.parse((sender.balance - amount).toStringAsFixed(2));
    final newReceiverBalance =
        double.parse((receiver.balance + amount).toStringAsFixed(2));

    if (newSenderBalance >= 0 && sender != receiver && amount > 0) {
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(sender.uid)
            .update({'balance': newSenderBalance});
        log(newSenderBalance.toString());

        await FirebaseFirestore.instance
            .collection('users')
            .doc(receiver.uid)
            .update({'balance': newReceiverBalance});

        final docTransaction =
            FirebaseFirestore.instance.collection('transactions').doc();
        final transaction = RMTransaction(
          senderUID: sender.uid,
          senderFullName: fullName(sender.name, sender.lastName),
          receiverUID: receiver.uid,
          receiverFullName: fullName(receiver.name, receiver.lastName),
          description: description,
          amount: amount,
          date: Timestamp.now(),
          id: docTransaction.id,
        );
        docTransaction.set(transaction.toJson());
      } catch (e) {
        log(e.toString());
      }
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
