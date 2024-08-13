import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:realmbank_mobile/data/models/user.dart';

class UserRepository {
  Future<RMUser?> getUser({
    required String uid,
  }) async {
    final docUser =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final userDoc = docUser.data() as Map<String, dynamic>;
    final user = RMUser.fromJson(userDoc);
    return user;
  }

  Stream<DocumentSnapshot> userStateChanges(String uid) {
    return FirebaseFirestore.instance.collection('users').doc(uid).snapshots();
  }
}
