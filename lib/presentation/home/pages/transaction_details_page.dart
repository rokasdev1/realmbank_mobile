import 'package:flutter/material.dart';
import 'package:realmbank_mobile/data/models/transaction.dart';
import 'package:realmbank_mobile/data/models/user.dart';
import 'package:realmbank_mobile/presentation/common/utils/extensions.dart';
import 'package:realmbank_mobile/presentation/common/utils/find_tools.dart';
import 'package:realmbank_mobile/presentation/common/utils/formatters.dart';

class TransactionDetailsPage extends StatelessWidget {
  const TransactionDetailsPage({super.key, required this.transaction});
  final RMTransaction transaction;

  @override
  Widget build(BuildContext context) {
    final List parts = transaction.amount.toStringAsFixed(2).split('.');
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Transaction details',
        ),
      ),
      body: FutureBuilder<List<RMUser>>(
          future: FindTools.findUsersWithUID(
              transaction.senderUID, transaction.receiverUID),
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
                              Formatters.numberWithCommas(parts[0]),
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
                          Formatters.dateFormat(transaction.date),
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
                      Divider(
                        color: context.colorScheme.surfaceContainerHigh,
                      ),
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
                      Divider(
                        color: context.colorScheme.surfaceContainerHigh,
                      ),
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
                      Divider(
                        color: context.colorScheme.surfaceContainerHigh,
                      ),
                    ],
                  )
                ],
              ),
            );
          }),
    );
  }
}
