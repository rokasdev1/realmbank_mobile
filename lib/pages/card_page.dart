import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:realmbank_mobile/models/user.dart';
import 'package:realmbank_mobile/pages/send_money_page.dart';
import 'package:realmbank_mobile/utils/extensions.dart';
import 'package:realmbank_mobile/widgets/big_button.dart';

class CardPage extends StatelessWidget {
  const CardPage({super.key, required this.user});
  final UserClass user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Card',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            16.heightBox,
            const Text(
              'My card',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            16.heightBox,
            BigButton(
              label: 'Send',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SendMoneyPage(sender: user),
                    ));
              },
            )
          ],
        ),
      ),
    );
  }
}
