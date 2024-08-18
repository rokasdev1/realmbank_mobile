import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zxing/flutter_zxing.dart';
import 'package:go_router/go_router.dart';
import 'package:realmbank_mobile/common/router_extras.dart';
import 'package:realmbank_mobile/common/routes.dart';
import 'package:realmbank_mobile/data/enums/toast_type.dart';
import 'package:realmbank_mobile/presentation/auth/pages/intro_page.dart';
import 'package:realmbank_mobile/presentation/common/providers/user_cubit.dart';
import 'package:realmbank_mobile/presentation/common/utils/extensions.dart';
import 'package:realmbank_mobile/presentation/common/utils/message_toaster.dart';

class QrScanPage extends StatefulWidget {
  const QrScanPage({super.key});

  @override
  State<QrScanPage> createState() => _QrScanPageState();
}

class _QrScanPageState extends State<QrScanPage> {
  @override
  void dispose() {
    zx.startCameraProcessing();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Scan QR Code',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is SuccessUserState) {
            final user = state.user;
            return ReaderWidget(
              showGallery: false,
              onScan: (result) {
                context.pop();
                if (result.text == null) return;
                if (result.text!.startsWith('RM')) {
                  final cardNum = result.text!;
                  SendMoneyRoute(
                      sendMoneyExtra: SendMoneyExtra(
                    user: user,
                    receiverCardNum: cardNum,
                  )).push();
                  return;
                }
                if (result.text!.startsWith('REQUEST-MONEY')) {
                  // 14 is the length of REQUEST-MONEY and the space
                  final info = result.text!.substring(14).split(':');
                  final requestorCardNum = info[0];
                  final amount = info[1];
                  final description = info[2];

                  if (requestorCardNum == user.cardNumber) {
                    MessageToaster.showMessage(
                      message: 'You cannot request money from yourself',
                      toastType: ToastType.error,
                    );
                    return;
                  }
                  SendMoneyRoute(
                    sendMoneyExtra: SendMoneyExtra(
                      user: user,
                      receiverCardNum: requestorCardNum,
                      amount: double.parse(amount),
                      description: description,
                      canEdit: false,
                    ),
                  ).push();
                  return;
                }
                MessageToaster.showMessage(
                  message: 'Invalid QR Code',
                  toastType: ToastType.error,
                );
              },
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
