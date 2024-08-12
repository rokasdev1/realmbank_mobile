import 'package:flutter/material.dart';
import 'package:realmbank_mobile/presentation/auth/login_register.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginOrRegister(),
                    ));
              },
              child: const Text('Log in'))
        ],
      ),
    );
  }
}
