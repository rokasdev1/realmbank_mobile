import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:realmbank_mobile/page_redirectors/login_register.dart';
import 'package:realmbank_mobile/pages/home_page.dart';
import 'package:realmbank_mobile/pages/login_page.dart';
import 'package:realmbank_mobile/pages/start_page.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const HomePage();
        } else {
          return const StartPage();
        }
      },
    );
  }
}
