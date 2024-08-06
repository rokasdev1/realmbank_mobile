import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:realmbank_mobile/models/transaction.dart';
import 'package:realmbank_mobile/models/user.dart';
import 'package:realmbank_mobile/pages/send_money_page.dart';
import 'package:realmbank_mobile/utils/extensions.dart';
import 'package:realmbank_mobile/widgets/big_button.dart';
import 'package:realmbank_mobile/widgets/money_widget.dart';
import 'package:realmbank_mobile/widgets/transactions_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.user});
  final UserClass user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Home',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.heightBox,
            const Text(
              'Total balance',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            8.heightBox,
            MoneyWidget(money: user.balance),
            16.heightBox,
            BigButton(
              label: 'Send',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SendMoneyPage(
                      sender: user,
                    ),
                  ),
                );
              },
            ),
            36.heightBox,
            const Text(
              'Transactions',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            16.heightBox,
            const TransactionsWidget(),
          ],
        ),
      ),
    );
  }
}
