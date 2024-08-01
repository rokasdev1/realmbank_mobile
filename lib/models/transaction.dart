import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:realmbank_mobile/models/user.dart';

class Transaction {
  final String senderUID;
  final String receiverUID;
  final double amount;
  final String id;

  Transaction({
    required this.senderUID,
    required this.receiverUID,
    required this.amount,
    required this.id,
  });

  Map<String, dynamic> toJson() => {
        'senderUID': senderUID,
        'receiverUID': receiverUID,
        'amount': amount,
        'id': id,
      };

  static Transaction fromJson(Map<String, dynamic> json) => Transaction(
        senderUID: json['senderUID'],
        receiverUID: json['receiverUID'],
        amount: json['amount'],
        id: json['id'],
      );
}

Future<void> sendMoney(
    UserClass sender, UserClass receiver, double amount) async {
  final newSenderBalance = sender.balance - amount;
  final newReceiverBalance = receiver.balance + amount;

  // Remove money from sender
  await FirebaseFirestore.instance
      .collection('users')
      .doc(sender.uid)
      .update({'balance': newSenderBalance});
  log(newSenderBalance.toString());

  // Add money to receiver
  await FirebaseFirestore.instance
      .collection('users')
      .doc(receiver.uid)
      .update({'balance': newReceiverBalance});

  // Log the transaction
  final docTransaction =
      FirebaseFirestore.instance.collection('transactions').doc();
  final transaction = Transaction(
    senderUID: sender.uid,
    receiverUID: receiver.uid,
    amount: amount,
    id: docTransaction.id,
  );
  await docTransaction.set(transaction.toJson());
}
