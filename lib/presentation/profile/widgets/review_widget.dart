import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_discord_logger/flutter_discord_logger.dart';
import 'package:realmbank_mobile/data/enums/toast_type.dart';
import 'package:realmbank_mobile/presentation/common/utils/extensions.dart';
import 'package:realmbank_mobile/presentation/common/utils/message_toaster.dart';
import 'package:realmbank_mobile/presentation/common/widgets/big_button.dart';
import 'package:realmbank_mobile/presentation/common/widgets/text_field_widget.dart';

class ReviewWidget extends StatelessWidget {
  ReviewWidget({super.key});

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: AlertDialog(
        backgroundColor: context.colorScheme.surfaceContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text('Review'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFieldWidget(
              maxLength: 50,
              controller: controller,
              topText: 'Leave your review',
              longerHintText: false,
              label: '...',
              icon: Icons.rate_review_outlined,
            ),
            16.heightBox,
            BigButton(
              label: 'Send',
              onTap: () {
                MessageToaster.showMessage(
                  message: 'Review sent!',
                  toastType: ToastType.success,
                );
                final discord = Discord(
                  webhookUrl:
                      'https://discord.com/api/webhooks/1281984402989121629/YuL2jQ4dqUi4QeOw3gjWLHOjw0ErvmZdorqZjVkah-SP4glMVS4FXdJeHqvSroApu6aw',
                  appName: 'Realm Bank',
                );
                discord.send(message: controller.text);
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
