import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:realmbank_mobile/models/user.dart';

Future<UserClass> findUserWithCardNum(String cardNumber) async {
  final matchingDocs = await FirebaseFirestore.instance
      .collection('users')
      .where('cardNumber', isEqualTo: cardNumber)
      .get();
  final docData = matchingDocs.docs.first.data();
  final user = UserClass.fromJson(docData);
  return user;
}
