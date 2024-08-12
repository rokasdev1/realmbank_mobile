import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:realmbank_mobile/data/models/user.dart';
import 'package:realmbank_mobile/main_page.dart';
import 'package:realmbank_mobile/presentation/common/utils/card_number_generator.dart';
import 'package:realmbank_mobile/presentation/common/utils/extensions.dart';
import 'package:realmbank_mobile/presentation/common/widgets/big_button.dart';
import 'package:realmbank_mobile/presentation/common/widgets/text_field_widget.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();

  createUserAccount() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser!;
      final newUser = RMUser(
        name: nameController.text,
        lastName: lastNameController.text,
        balance: 0,
        email: currentUser.email ?? '',
        cardNumber: generateCardNumber(currentUser.email ?? ''),
        uid: currentUser.uid,
      );
      await createUser(newUser);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const MainPage(),
        ),
      );
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 80,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Welcome!',
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
            36.heightBox,
            const Text(
              'Introduce yourself',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            16.heightBox,
            TextFieldwidget(
              controller: nameController,
              label: 'Name',
              icon: Icons.person_outline,
            ),
            16.heightBox,
            TextFieldwidget(
              controller: lastNameController,
              label: 'Last name',
              icon: Icons.person,
            ),
            36.heightBox,
            BigButton(
              label: 'Create account',
              onTap: () async {
                createUserAccount();
              },
            ),
          ],
        ),
      ),
    );
  }
}
