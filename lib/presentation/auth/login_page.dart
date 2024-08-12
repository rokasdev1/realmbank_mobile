import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:realmbank_mobile/presentation/common/utils/extensions.dart';
import 'package:realmbank_mobile/presentation/common/widgets/big_button.dart';
import 'package:realmbank_mobile/presentation/auth/widgets/google_button.dart';
import 'package:realmbank_mobile/presentation/common/widgets/text_field_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.onSwitch});
  final VoidCallback onSwitch;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String errorMessage = '';

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 80,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                height: 80,
                child: SvgPicture.asset('assets/realm.svg'),
              ),
            ),
            36.heightBox,
            const Text('Log In',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            16.heightBox,
            TextFieldwidget(
              controller: emailController,
              label: 'Email',
              icon: Icons.email_outlined,
            ),
            16.heightBox,
            TextFieldwidget(
              controller: passwordController,
              label: 'Password',
              icon: Icons.lock_outline,
              isObscure: true,
            ),
            24.heightBox,
            BigButton(
              onTap: () async {
                final email = emailController.text;
                final password = passwordController.text;

                try {
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email, password: password);
                  Navigator.pop(context);
                } on FirebaseAuthException catch (e) {
                  setState(() {
                    errorMessage = e.message!;
                  });
                }
              },
              label: 'Login',
            ),
            36.heightBox,
            Opacity(
              opacity: 0.6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Divider(color: Colors.grey.shade300)),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'OR',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.grey.shade300)),
                ],
              ),
            ),
            36.heightBox,
            GoogleButton(
              onTap: () {},
              isLogin: true,
            ),
            36.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have account? ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                InkWell(
                  onTap: widget.onSwitch,
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Color.fromRGBO(94, 98, 239, 1),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
