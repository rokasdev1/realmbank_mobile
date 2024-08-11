import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:realmbank_mobile/models/transaction.dart';

class TransactionMoneyWidget extends StatelessWidget {
  const TransactionMoneyWidget(
      {super.key, required this.transaction, required this.userUID});
  final TransactionModel transaction;
  final String userUID;

  @override
  Widget build(BuildContext context) {
    final isSender = transaction.senderUID == userUID;
    return Text(
      isSender ? "-\$${transaction.amount}" : "+\$${transaction.amount}",
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: isSender ? Colors.red : Colors.green),
    );
  }
}
