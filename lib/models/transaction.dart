import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:realmbank_mobile/models/user.dart';
import 'package:realmbank_mobile/utils/date_converter.dart';
import 'package:realmbank_mobile/utils/full_name.dart';

class TransactionModel {
  final String senderUID;
  final String senderFullName;
  final String receiverUID;
  final String receiverFullName;
  final String description;
  final double amount;
  final Timestamp date;

  TransactionModel({
    required this.senderUID,
    required this.senderFullName,
    required this.receiverUID,
    required this.receiverFullName,
    required this.description,
    required this.amount,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
        'senderUID': senderUID,
        'senderFullName': senderFullName,
        'receiverUID': receiverUID,
        'receiverFullName': receiverFullName,
        'description': description,
        'amount': amount,
        'date': date,
      };

  static TransactionModel fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        senderUID: json['senderUID'],
        senderFullName: json['senderFullName'],
        receiverUID: json['receiverUID'],
        receiverFullName: json['receiverFullName'],
        description: json['description'],
        amount: json['amount'],
        date: json['date'],
      );
}

Future<void> sendMoney(UserClass sender, UserClass receiver, double amount,
    String description) async {
  final newSenderBalance =
      double.parse((sender.balance - amount).toStringAsFixed(2));
  final newReceiverBalance =
      double.parse((receiver.balance + amount).toStringAsFixed(2));

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
  final transaction = TransactionModel(
    senderUID: sender.uid,
    senderFullName: fullName(sender.name, sender.lastName),
    receiverUID: receiver.uid,
    receiverFullName: fullName(receiver.name, receiver.lastName),
    description: description,
    amount: amount,
    date: Timestamp.now(),
  );
  docTransaction.set(transaction.toJson());
}
