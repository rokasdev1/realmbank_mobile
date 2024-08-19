import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:realmbank_mobile/data/models/request.dart';
import 'package:realmbank_mobile/data/models/user.dart';

class RequestRepository {
  Stream<QuerySnapshot> getReceivedRequestsStream() {
    final userUID = FirebaseAuth.instance.currentUser?.uid;

    if (userUID == null) {
      return const Stream.empty();
    }

    final receivedRequestsStream = FirebaseFirestore.instance
        .collection('requests')
        .where('requesteeUID', isEqualTo: userUID)
        .snapshots();
    return receivedRequestsStream;
  }

  Future<QuerySnapshot?> getSentRequests() async {
    final userUID = FirebaseAuth.instance.currentUser?.uid;

    if (userUID == null) {
      return null;
    }

    final sentRequestsStream = await FirebaseFirestore.instance
        .collection('requests')
        .where('requestorUID', isEqualTo: userUID)
        .get();
    return sentRequestsStream;
  }

  Future<void> createRequest({
    required RMUser requestor,
    required RMUser requestee,
    required double amount,
    required String description,
  }) async {
    final requestDoc = FirebaseFirestore.instance.collection('requests').doc();

    final request = Request(
      requestorUID: requestor.uid,
      requesteeUID: requestee.uid,
      amount: amount,
      description: description,
      timestamp: Timestamp.now(),
      id: requestDoc.id,
    );

    await requestDoc.set(
      request.toJson(),
    );
  }

  Future<void> closeRequest({
    required String requestId,
  }) async {
    await FirebaseFirestore.instance
        .collection('requests')
        .doc(requestId)
        .delete();
  }
}
