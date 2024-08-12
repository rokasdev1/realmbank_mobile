import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:realmbank_mobile/data/models/user.dart';
import 'package:realmbank_mobile/presentation/common/utils/full_name.dart';

class RMTransaction {
  final String senderUID;
  final String senderFullName;
  final String receiverUID;
  final String receiverFullName;
  final String description;
  final double amount;
  final Timestamp date;
  final String id;

  RMTransaction({
    required this.senderUID,
    required this.senderFullName,
    required this.receiverUID,
    required this.receiverFullName,
    required this.description,
    required this.amount,
    required this.date,
    required this.id,
  });

  Map<String, dynamic> toJson() => {
        'senderUID': senderUID,
        'senderFullName': senderFullName,
        'receiverUID': receiverUID,
        'receiverFullName': receiverFullName,
        'description': description,
        'amount': amount,
        'date': date,
        'id': id,
      };

  static RMTransaction fromJson(Map<String, dynamic> json) => RMTransaction(
        senderUID: json['senderUID'],
        senderFullName: json['senderFullName'],
        receiverUID: json['receiverUID'],
        receiverFullName: json['receiverFullName'],
        description: json['description'],
        amount: json['amount'],
        date: json['date'],
        id: json['id'],
      );
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
