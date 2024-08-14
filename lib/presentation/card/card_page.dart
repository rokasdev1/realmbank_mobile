import 'package:flutter/material.dart';
import 'package:realmbank_mobile/common/routes.dart';
import 'package:realmbank_mobile/data/models/user.dart';
import 'package:realmbank_mobile/presentation/common/utils/extensions.dart';
import 'package:realmbank_mobile/presentation/common/widgets/big_button.dart';

class CardPage extends StatelessWidget {
  const CardPage({super.key, required this.user});
  final RMUser user;

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
                context.pushRoute(SendMoneyRoute(user: user));
              },
            )
          ],
        ),
      ),
    );
  }
}
