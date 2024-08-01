import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:realmbank_mobile/models/transaction.dart';
import 'package:realmbank_mobile/models/user.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;
            final user = UserClass.fromJson(userData);
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(user.balance.toString(),
                    style: const TextStyle(fontSize: 24)),
                ElevatedButton(
                  onPressed: () {
                    sendMoney(
                      user,
                      UserClass(
                          name: 'meinen name',
                          lastName: 'meneine',
                          balance: 0,
                          email: 'abab@abab.com',
                          uid: 'q5EosbxT1mODVJ5RpadKq4NUGGZ2'),
                      5.1,
                    );
                  },
                  child: const Text('Send'),
                ),
                ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  child: const Text('Sign out'),
                )
              ],
            ));
          } else {
            return const Center(
              child: Text('There has been an error.'),
            );
          }
        },
      ),
    );
  }
}
