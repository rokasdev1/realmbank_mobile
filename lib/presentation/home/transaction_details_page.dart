import 'package:flutter/material.dart';
import 'package:realmbank_mobile/common/models/transaction.dart';
import 'package:realmbank_mobile/common/models/user.dart';
import 'package:realmbank_mobile/utils/date_converter.dart';
import 'package:realmbank_mobile/utils/extensions.dart';
import 'package:realmbank_mobile/utils/find_user_utils.dart';
import 'package:realmbank_mobile/utils/number_format.dart';

class TransactionDetailsPage extends StatelessWidget {
  const TransactionDetailsPage({super.key, required this.transaction});
  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    final List parts = transaction.amount.toStringAsFixed(2).split('.');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Transaction details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<UserClass>>(
          future:
              findUsersWithUID(transaction.senderUID, transaction.receiverUID),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final sender = snapshot.data![0];
            final isSender = transaction.senderUID == sender.uid;
            final receiver = snapshot.data![1];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  16.heightBox,
                  Center(
                    child: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              isSender ? '' : '-',
                              style: const TextStyle(
                                  fontSize: 70,
                                  fontWeight: FontWeight.w900,
                                  height: 0),
                            ),
                            Text(
                              formatNumberWithCommas(parts[0]),
                              style: const TextStyle(
                                  fontSize: 70,
                                  fontWeight: FontWeight.w900,
                                  height: 0),
                            ),
                            Text(
                              '.${parts[1]}',
                              style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w900,
                                  height: 1.8),
                            ),
                          ],
                        ),
                        Text(
                          dateConvert(transaction.date),
                        ),
                      ],
                    ),
                  ),
                  48.heightBox,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      4.heightBox,
                      Text(
                        'Sender',
                        style: TextStyle(
                            fontSize: 16, color: Colors.grey.shade600),
                      ),
                      Text(
                        transaction.senderFullName.toUpperCase(),
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        sender.cardNumber,
                      ),
                      const Divider(),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      4.heightBox,
                      Text(
                        'Receiver',
                        style: TextStyle(
                            fontSize: 16, color: Colors.grey.shade600),
                      ),
                      Text(
                        transaction.receiverFullName.toUpperCase(),
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        receiver.cardNumber,
                      ),
                      const Divider(),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      4.heightBox,
                      Text(
                        'Transaction description',
                        style: TextStyle(
                            fontSize: 16, color: Colors.grey.shade600),
                      ),
                      Text(
                        transaction.description,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const Divider(),
                    ],
                  )
                ],
              ),
            );
          }),
    );
  }
}
