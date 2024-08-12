import 'package:flutter/material.dart';
import 'package:realmbank_mobile/data/models/transaction.dart';

class TransactionMoneyWidget extends StatelessWidget {
  const TransactionMoneyWidget(
      {super.key, required this.transaction, required this.userUID});
  final RMTransaction transaction;
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
