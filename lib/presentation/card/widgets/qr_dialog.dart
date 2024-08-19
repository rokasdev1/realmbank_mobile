import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:realmbank_mobile/presentation/common/utils/extensions.dart';
import 'package:realmbank_mobile/presentation/common/widgets/big_button.dart';

class QrDialog extends StatelessWidget {
  const QrDialog({super.key, required this.data});
  final String data;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: AlertDialog(
        backgroundColor: Colors.white,
        content: Container(
          padding: const EdgeInsets.all(8),
          height: 350,
          width: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color.fromRGBO(94, 98, 239, 1),
                    width: 10,
                  ),
                ),
                child: QrImageView(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.black,
                  data: data,
                  size: 200,
                ),
              ),
              const Text(
                'Anyone can scan this QR code',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              8.heightBox,
              BigButton(
                label: 'Close',
                onTap: () {
                  context.pop();
                  context.pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
