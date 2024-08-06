import 'package:cloud_firestore/cloud_firestore.dart';

class UserClass {
  final String name;
  final String lastName;
  final double balance;
  final String email;
  final String cardNumber;
  late String uid;

  UserClass({
    required this.name,
    required this.lastName,
    required this.balance,
    required this.email,
    required this.cardNumber,
    required this.uid,
  });
  Map<String, dynamic> toJson() => {
        'name': name,
        'lastName': lastName,
        'balance': balance,
        'email': email,
        'cardNumber': cardNumber,
        'uid': uid,
      };

  static UserClass fromJson(Map<String, dynamic> json) => UserClass(
        name: json['name'],
        lastName: json['lastName'],
        balance: (json['balance'] is int)
            ? (json['balance'] as int).toDouble()
            : (json['balance'] as double),
        email: json['email'],
        cardNumber: json['cardNumber'],
        uid: json['uid'],
      );
}

Future<void> createUser(UserClass user) async {
  final docUser = FirebaseFirestore.instance.collection('users').doc(user.uid);
  final json = user.toJson();
  await docUser.set(json);
}
