import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:realmbank_mobile/common/routes.dart';
import 'package:realmbank_mobile/data/models/transaction.dart';
import 'package:realmbank_mobile/presentation/home/transaction_details_page.dart';
import 'package:realmbank_mobile/presentation/common/utils/date_converter.dart';
import 'package:realmbank_mobile/presentation/common/utils/extensions.dart';
import 'package:realmbank_mobile/presentation/home/widgets/transaction_money_widget.dart';
import 'package:rxdart/rxdart.dart';

class TransactionsWidget extends StatefulWidget {
  const TransactionsWidget({super.key});

  @override
  State<TransactionsWidget> createState() => _TransactionsWidgetState();
}

class _TransactionsWidgetState extends State<TransactionsWidget> {
  final userUID = FirebaseAuth.instance.currentUser!.uid;
  final accentColor = const Color.fromRGBO(94, 98, 239, 1);

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

  String _sentOrReceivedFullName(RMTransaction transaction) {
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
            final transaction = RMTransaction.fromJson(transactionData);
            return GestureDetector(
              onTap: () {
                context.pushRoute(
                    TransactionDetailsRoute(transaction: transaction));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey.shade100,
                          radius: 25,
                          child: Icon(
                            Icons.send_to_mobile,
                            color: accentColor,
                          ),
                        ),
                        16.widthBox,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _sentOrReceivedFullName(transaction),
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              dateConvert(transaction.date),
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    TransactionMoneyWidget(
                        transaction: transaction, userUID: userUID),
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
