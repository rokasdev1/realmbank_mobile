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
  const HomePage({super.key});

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
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;
            final user = UserClass.fromJson(userData);
            return Padding(
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
                  const TransactionsWidget(),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text('There has been an error.'),
            );
          }
        },
      ),
    );
  }
}
