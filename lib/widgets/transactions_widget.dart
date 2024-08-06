import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:realmbank_mobile/models/transaction.dart';
import 'package:realmbank_mobile/utils/date_converter.dart';
import 'package:realmbank_mobile/utils/money_formatter.dart';

class TransactionsWidget extends StatefulWidget {
  const TransactionsWidget({super.key});

  @override
  State<TransactionsWidget> createState() => _TransactionsWidgetState();
}

class _TransactionsWidgetState extends State<TransactionsWidget> {
  late Future<List<QueryDocumentSnapshot>> myTransactionsFuture;
  final userUID = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    myTransactionsFuture = _fetchTransactions();
  }

  Future<List<QueryDocumentSnapshot>> _fetchTransactions() async {
    final sentQuerySnapshot = await FirebaseFirestore.instance
        .collection('transactions')
        .where('senderUID', isEqualTo: userUID)
        .get();

    final receivedQuerySnapshot = await FirebaseFirestore.instance
        .collection('transactions')
        .where('receiverUID', isEqualTo: userUID)
        .get();

    final allTransactions = [
      ...sentQuerySnapshot.docs,
      ...receivedQuerySnapshot.docs
    ];

    allTransactions.sort((a, b) {
      final aTimestamp = (a.data())['date'] as Timestamp;
      final bTimestamp = (b.data())['date'] as Timestamp;
      return bTimestamp.compareTo(aTimestamp);
    });

    return allTransactions;
  }

  Future<void> _refreshTransactions() async {
    setState(() {
      myTransactionsFuture = _fetchTransactions();
    });
    await myTransactionsFuture;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<QueryDocumentSnapshot>>(
      future: myTransactionsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No transactions found.');
        }

        final myTransactions = snapshot.data!;
        return RefreshIndicator(
          onRefresh: () => _refreshTransactions(),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: myTransactions.length,
            itemBuilder: (context, index) {
              final transactionData =
                  myTransactions[index].data() as Map<String, dynamic>;
              final transaction = TransactionModel.fromJson(transactionData);
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          transaction.senderFullName,
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
              );
            },
          ),
        );
      },
    );
  }
}
