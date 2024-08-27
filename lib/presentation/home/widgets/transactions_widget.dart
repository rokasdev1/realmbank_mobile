import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realmbank_mobile/common/routes.dart';
import 'package:realmbank_mobile/data/models/transaction.dart';
import 'package:realmbank_mobile/presentation/common/providers/transaction_cubit.dart';
import 'package:realmbank_mobile/presentation/common/utils/extensions.dart';
import 'package:realmbank_mobile/presentation/common/widgets/date_list_tile.dart';
import 'package:realmbank_mobile/presentation/home/widgets/transaction_money_widget.dart';

class TransactionsWidget extends StatefulWidget {
  const TransactionsWidget({super.key});

  @override
  State<TransactionsWidget> createState() => _TransactionsWidgetState();
}

class _TransactionsWidgetState extends State<TransactionsWidget> {
  final userUID = FirebaseAuth.instance.currentUser!.uid;

  String _sentOrReceivedFullName(RMTransaction transaction) {
    if (transaction.senderUID == userUID) {
      return transaction.receiverFullName;
    } else {
      return transaction.senderFullName;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionCubit, TransactionState>(
      builder: (context, state) {
        if (state is LoadingTransactionState) {
          return const CircularProgressIndicator();
        } else if (state is FailedTransactionState) {
          return Text(state.message);
        } else if (state is SuccessTransactionState &&
            state.transactions.isEmpty) {
          return const Text('No transactions found.');
        }

        final myTransactions = state is SuccessTransactionState
            ? state.transactions
            : <QueryDocumentSnapshot>[];
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: myTransactions.length,
          itemBuilder: (context, index) {
            final transactionData =
                myTransactions[index].data() as Map<String, dynamic>;
            final transaction = RMTransaction.fromJson(transactionData);

            return DateListTile(
              onTap: () {
                context.pushRoute(
                    TransactionDetailsRoute(transaction: transaction));
              },
              icon: Icons.send_to_mobile,
              title: _sentOrReceivedFullName(transaction),
              trailing: TransactionMoneyWidget(
                  transaction: transaction, userUID: userUID),
              date: transaction.date,
            );
          },
        );
      },
    );
  }
}
