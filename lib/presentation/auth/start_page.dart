import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:realmbank_mobile/common/routes.dart';
import 'package:realmbank_mobile/presentation/auth/login_register.dart';
import 'package:realmbank_mobile/presentation/common/utils/extensions.dart';

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
                context.pushRoute(LoginRegisterRoute());
              },
              child: const Text('Log in'))
        ],
      ),
    );
  }
}
