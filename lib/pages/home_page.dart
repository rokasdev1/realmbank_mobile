import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Home page', style: TextStyle(fontSize: 24)),
          ElevatedButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            child: const Text('Sign out'),
          )
        ],
      )),
    );
  }
}
