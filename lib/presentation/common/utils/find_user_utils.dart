import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:realmbank_mobile/data/models/user.dart';

Future<RMUser> findUserWithCardNum(String cardNumber) async {
  final matchingDocs = await FirebaseFirestore.instance
      .collection('users')
      .where('cardNumber', isEqualTo: cardNumber)
      .get();
  final docData = matchingDocs.docs.first.data();
  final user = RMUser.fromJson(docData);
  return user;
}

Future<List<RMUser>> findUsersWithUID(
    String senderUID, String receiverUID) async {
  final senderMatchingDocs = await FirebaseFirestore.instance
      .collection('users')
      .where('uid', isEqualTo: senderUID)
      .get();
  final senderDocData = senderMatchingDocs.docs.first.data();
  final sender = RMUser.fromJson(senderDocData);

  final receiverMatchingDocs = await FirebaseFirestore.instance
      .collection('users')
      .where('uid', isEqualTo: receiverUID)
      .get();
  final receiverDocData = receiverMatchingDocs.docs.first.data();
  final receiver = RMUser.fromJson(receiverDocData);
  return [
    sender,
    receiver,
  ];
}
