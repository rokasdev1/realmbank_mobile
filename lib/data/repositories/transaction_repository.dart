import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:realmbank_mobile/data/models/transaction.dart';
import 'package:realmbank_mobile/data/models/user.dart';
import 'package:realmbank_mobile/presentation/common/utils/full_name.dart';
import 'package:rxdart/rxdart.dart';

class TransactionRepository {
  Stream<List<QueryDocumentSnapshot>> getTransactionStream() {
    final userUID = FirebaseAuth.instance.currentUser?.uid;

    if (userUID == null) {
      return const Stream.empty();
    }

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

  Future<RMTransaction?> logTransaction({
    required RMUser sender,
    required RMUser receiver,
    required double amount,
    required String description,
  }) async {
    try {
      final docTransaction =
          FirebaseFirestore.instance.collection('transactions').doc();
      final transaction = RMTransaction(
        senderUID: sender.uid,
        senderFullName: fullName(sender.name, sender.lastName),
        receiverUID: receiver.uid,
        receiverFullName: fullName(receiver.name, receiver.lastName),
        description: description,
        amount: amount,
        date: Timestamp.now(),
        id: docTransaction.id,
      );
      docTransaction.set(transaction.toJson());
      return transaction;
    } catch (e) {
      log('TransactionRepository.logTransaction: Error: $e');
      return null;
    }
  }
}
