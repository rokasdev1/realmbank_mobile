import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:realmbank_mobile/models/user.dart';
import 'package:realmbank_mobile/utils/extensions.dart';
import 'package:realmbank_mobile/widgets/big_button.dart';
import 'package:realmbank_mobile/widgets/list_tile_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.user});
  final UserClass user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Column(
              children: [
                100.heightBox,
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(94, 98, 239, 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: QrImageView(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    data: user.cardNumber,
                    size: 125,
                  ),
                ),
                16.heightBox,
                Text(
                  user.name[0].toUpperCase() + user.name.substring(1),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 40),
                ),
                8.heightBox,
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: ShapeDecoration(
                    color: Colors.grey.shade200,
                    shape: const StadiumBorder(),
                  ),
                  child: Text(
                    user.email,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                36.heightBox,
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      ListTileWidget(
                        leading: Icons.account_circle_outlined,
                        text: 'Account',
                        onTap: () {},
                        trailing: Icons.arrow_forward_ios_rounded,
                      ),
                      4.heightBox,
                      ListTileWidget(
                        leading: Icons.contacts_outlined,
                        text: 'Contacts',
                        onTap: () {},
                        trailing: Icons.arrow_forward_ios_rounded,
                      ),
                      4.heightBox,
                      ListTileWidget(
                        leading: Icons.settings_outlined,
                        text: 'Settings',
                        onTap: () {},
                        trailing: Icons.arrow_forward_ios_rounded,
                      ),
                    ],
                  ),
                ),
                16.heightBox,
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      ListTileWidget(
                        leading: Icons.arrow_upward_rounded,
                        text: 'Send money',
                        onTap: () {},
                        trailing: Icons.arrow_forward_ios_rounded,
                      ),
                      4.heightBox,
                      ListTileWidget(
                        leading: Icons.arrow_downward_rounded,
                        text: 'Receive money',
                        onTap: () {},
                        trailing: Icons.arrow_forward_ios_rounded,
                      ),
                      4.heightBox,
                      ListTileWidget(
                        leading: Icons.credit_card,
                        text: 'Card info',
                        onTap: () {},
                        trailing: Icons.arrow_forward_ios_rounded,
                      ),
                      4.heightBox,
                      ListTileWidget(
                        leading: Icons.perm_device_information_outlined,
                        text: 'About Realm Bank',
                        onTap: () {},
                        trailing: Icons.arrow_forward_ios_rounded,
                      ),
                    ],
                  ),
                ),
                16.heightBox,
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      ListTileWidget(
                        leading: Icons.logout_outlined,
                        text: 'Log out',
                        foregroundColor: Colors.red,
                        onTap: () {
                          FirebaseAuth.instance.signOut();
                        },
                        trailing: Icons.arrow_forward_ios_rounded,
                        noTrailing: true,
                      ),
                    ],
                  ),
                ),
                16.heightBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
