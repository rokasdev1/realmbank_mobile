import 'package:flutter/material.dart';
import 'package:realmbank_mobile/utils/extensions.dart';

class GoogleButton extends StatefulWidget {
  const GoogleButton({
    super.key,
    required this.onTap,
    required this.isLogin,
  });
  final VoidCallback onTap;
  final bool isLogin;

  @override
  State<GoogleButton> createState() => _GoogleButtonState();
}

class _GoogleButtonState extends State<GoogleButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(
              color: const Color.fromARGB(71, 199, 199, 199), width: 2),
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 25,
              width: 25,
              child: Image.asset('assets/google.png'),
            ),
            8.widthBox,
            Text(
              widget.isLogin ? 'Login with Google' : 'Sign up with Google',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )),
      ),
    );
  }
}
