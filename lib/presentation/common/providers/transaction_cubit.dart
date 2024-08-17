import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realmbank_mobile/common/routes.dart';
import 'package:realmbank_mobile/data/enums/toast_type.dart';
import 'package:realmbank_mobile/data/models/user.dart';
import 'package:realmbank_mobile/data/repositories/transaction_repository.dart';
import 'package:realmbank_mobile/presentation/common/utils/extensions.dart';
import 'package:realmbank_mobile/presentation/common/utils/message_toaster.dart';

class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit({required this.transactionRepository})
      : super(InitialTransactionState());

  final TransactionRepository transactionRepository;
  StreamSubscription? transactionStateChanges;

  Future<void> getTransactions() async {
    transactionStateChanges?.cancel();
    try {
      emit(LoadingTransactionState());
      transactionStateChanges =
          transactionRepository.getTransactionStream().listen(
        (transactions) {
          emit(
            SuccessTransactionState(transactions: transactions),
          );
        },
      );
    } catch (e) {
      log('TransactionCubit.getTransactions: Error: $e');
      emit(FailedTransactionState(e.toString()));
    }
  }

  Future<void> sendMoney({
    required RMUser sender,
    required RMUser receiver,
    required double amount,
    required String description,
  }) async {
    final newSenderBalance =
        double.parse((sender.balance - amount).toStringAsFixed(2));
    final newReceiverBalance =
        double.parse((receiver.balance + amount).toStringAsFixed(2));

    if (newSenderBalance < 0) {
      const message = 'Insufficient funds';
      MessageToaster.showMessage(
        message: message,
        toastType: ToastType.error,
      );
      return;
    }

    if (sender.uid == receiver.uid) {
      const message = 'You cannot send money to yourself';
      MessageToaster.showMessage(
        message: message,
        toastType: ToastType.error,
      );
      return;
    }

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

      final transaction = await transactionRepository.logTransaction(
        sender: sender,
        receiver: receiver,
        amount: amount,
        description: description,
      );

      if (transaction != null) {
        MessageToaster.showMessage(
          message: 'Money sent successfully',
          toastType: ToastType.success,
          onDismiss: () {
            TransactionDetailsRoute(transaction: transaction).push();
          },
        );
      }
    } catch (e) {
      MessageToaster.showMessage(
        message: 'An error has occured',
        toastType: ToastType.error,
      );
      log('TransactionCubit.sendMoney: Error: $e');
    }
  }
}

abstract class TransactionState {}

class InitialTransactionState extends TransactionState {}

class LoadingTransactionState extends TransactionState {}

class SuccessTransactionState extends TransactionState {
  SuccessTransactionState({
    required this.transactions,
  });
  final List<QueryDocumentSnapshot> transactions;
}

class FailedTransactionState extends TransactionState {
  FailedTransactionState(this.message);
  final String message;
}
