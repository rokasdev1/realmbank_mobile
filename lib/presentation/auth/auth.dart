import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:realmbank_mobile/presentation/auth/intro_page.dart';
import 'package:realmbank_mobile/main_page.dart';
import 'package:realmbank_mobile/presentation/auth/start_page.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  Future<bool> hasFirestoreDocument() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final documents =
        await FirebaseFirestore.instance.collection('users').get();
    return documents.docs.any((element) => element.id == uid);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return FutureBuilder<bool>(
            future: hasFirestoreDocument(),
            builder: (context, hasFirestoreSnapshot) {
              if (hasFirestoreSnapshot.hasData &&
                  hasFirestoreSnapshot.data == true) {
                return const MainPage();
              } else {
                return const IntroPage();
              }
            },
          );
        } else {
          return const StartPage();
        }
      },
    );
  }
}
