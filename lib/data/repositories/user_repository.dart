import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:realmbank_mobile/data/models/user.dart';

class UserRepository {
  Future<RMUser?> getUser({
    required String uid,
  }) async {
    final docUser =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final userDoc = docUser.data();
    if (userDoc == null) {
      return null;
    }
    final RMUser user = RMUser.fromJson(userDoc);
    return user;
  }

  Future<void> createUser(RMUser user) async {
    final docUser =
        FirebaseFirestore.instance.collection('users').doc(user.uid);
    final json = user.toJson();
    await docUser.set(json);
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> userStateChanges(String uid) {
    return FirebaseFirestore.instance.collection('users').doc(uid).snapshots();
  }
}
