import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_discord_logger/flutter_discord_logger.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:realmbank_mobile/common/router_extras.dart';
import 'package:realmbank_mobile/common/routes.dart';
import 'package:realmbank_mobile/data/enums/toast_type.dart';
import 'package:realmbank_mobile/data/models/user.dart';
import 'package:realmbank_mobile/presentation/common/providers/auth_cubit.dart';
import 'package:realmbank_mobile/presentation/common/utils/extensions.dart';
import 'package:realmbank_mobile/presentation/common/utils/message_toaster.dart';
import 'package:realmbank_mobile/presentation/common/widgets/big_button.dart';
import 'package:realmbank_mobile/presentation/common/widgets/list_tile_widget.dart';
import 'package:realmbank_mobile/presentation/common/widgets/text_field_widget.dart';
import 'package:realmbank_mobile/presentation/profile/widgets/review_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.user});
  final RMUser user;

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
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: context.colorScheme.primary,
                      width: 10,
                    ),
                  ),
                  child: QrImageView(
                    backgroundColor: Colors.transparent,
                    foregroundColor: context.colorScheme.inverseSurface,
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
                    color: context.colorScheme.surfaceContainer,
                    shape: const StadiumBorder(),
                  ),
                  child: Text(
                    user.email,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                36.heightBox,
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      ListTileWidget(
                        leading: Icons.account_circle_outlined,
                        text: 'Account',
                        onTap: () {
                          AccountRoute().push();
                        },
                        trailingIcon: Icons.arrow_forward_ios_rounded,
                      ),
                      4.heightBox,
                      ListTileWidget(
                        leading: Icons.contacts_outlined,
                        text: 'Contacts',
                        onTap: () {
                          ContactsRoute().push();
                        },
                        trailingIcon: Icons.arrow_forward_ios_rounded,
                      ),
                      4.heightBox,
                      ListTileWidget(
                        leading: Icons.settings_outlined,
                        text: 'Settings',
                        onTap: () {
                          SettingsRoute().push();
                        },
                        trailingIcon: Icons.arrow_forward_ios_rounded,
                      ),
                    ],
                  ),
                ),
                16.heightBox,
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      ListTileWidget(
                        leading: Icons.arrow_upward_rounded,
                        text: 'Send money',
                        onTap: () {
                          SendMoneyRoute(
                            sendMoneyExtra: SendMoneyExtra(
                              sender: user,
                              receiverCardNum: '',
                            ),
                          ).push();
                        },
                        trailingIcon: Icons.arrow_forward_ios_rounded,
                      ),
                      4.heightBox,
                      ListTileWidget(
                        leading: Icons.arrow_downward_rounded,
                        text: 'Receive money',
                        onTap: () {
                          RequestMoneyRoute(
                            requestMoneyExtra: RequestMoneyExtra(
                              user: user,
                              cardNum: '',
                            ),
                          ).push();
                        },
                        trailingIcon: Icons.arrow_forward_ios_rounded,
                      ),
                      4.heightBox,
                      ListTileWidget(
                        leading: Icons.rate_review_outlined,
                        text: 'Review',
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => ReviewWidget(),
                          );
                        },
                        trailingIcon: Icons.arrow_forward_ios_rounded,
                      ),
                      4.heightBox,
                      ListTileWidget(
                        leading: Icons.perm_device_information_outlined,
                        text: 'About Realm Bank',
                        onTap: () {
                          launchUrl(
                            Uri.parse(
                                'https://github.com/rokasdev1/realmbank_mobile'),
                          );
                        },
                        trailingIcon: Icons.arrow_forward_ios_rounded,
                      ),
                    ],
                  ),
                ),
                16.heightBox,
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      ListTileWidget(
                        leading: Icons.logout_outlined,
                        text: 'Log out',
                        foregroundColor: Colors.red,
                        onTap: () {
                          context.read<AuthCubit>().signOut();
                        },
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
