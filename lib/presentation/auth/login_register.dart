import 'package:flutter/material.dart';
import 'package:realmbank_mobile/presentation/auth/login_page.dart';
import 'package:realmbank_mobile/presentation/auth/register_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onSwitch: togglePages);
    } else {
      return RegisterPage(onSwitch: togglePages);
    }
  }
}
