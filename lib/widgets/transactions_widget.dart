import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:realmbank_mobile/models/transaction.dart';
import 'package:realmbank_mobile/pages/transaction_details_page.dart';
import 'package:realmbank_mobile/utils/date_converter.dart';
import 'package:realmbank_mobile/utils/money_formatter.dart';
import 'package:rxdart/rxdart.dart';

class TransactionsWidget extends StatefulWidget {
  const TransactionsWidget({super.key});

  @override
  State<TransactionsWidget> createState() => _TransactionsWidgetState();
}

class _TransactionsWidgetState extends State<TransactionsWidget> {
  final userUID = FirebaseAuth.instance.currentUser!.uid;

  Stream<List<QueryDocumentSnapshot>> _transactionStream() {
    final sentQuerySnapshots = FirebaseFirestore.instance
        .collection('transactions')
        .where('senderUID', isEqualTo: userUID)
        .snapshots();

    final receivedQuerySnapshots = FirebaseFirestore.instance
        .collection('transactions')
        .where('receiverUID', isEqualTo: userUID)
        .snapshots();

    return Rx.combineLatest2(sentQuerySnapshots, receivedQuerySnapshots,
        (QuerySnapshot sentSnapshot, QuerySnapshot receivedSnapshot) {
      final allDocuments = [
        ...sentSnapshot.docs,
        ...receivedSnapshot.docs,
      ];

      allDocuments.sort((a, b) {
        final timestampA = a['date'] as Timestamp;
        final timestampB = b['date'] as Timestamp;
        return timestampB.compareTo(timestampA);
      });

      return allDocuments;
    });
  }

  String _sentOrReceivedFullName(TransactionModel transaction) {
    if (transaction.senderUID == userUID) {
      return transaction.receiverFullName;
    } else {
      return transaction.senderFullName;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<QueryDocumentSnapshot>>(
      stream: _transactionStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No transactions found.');
        }

        final myTransactions = snapshot.data!;
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: myTransactions.length,
          itemBuilder: (context, index) {
            final transactionData =
                myTransactions[index].data() as Map<String, dynamic>;
            final transaction = TransactionModel.fromJson(transactionData);
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        TransactionDetailsPage(transaction: transaction),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _sentOrReceivedFullName(transaction),
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(dateConvert(transaction.date)),
                      ],
                    ),
                    Text(
                      moneyFormat(transaction, userUID),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
