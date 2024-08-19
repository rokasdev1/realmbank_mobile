import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:realmbank_mobile/data/models/user.dart';
import 'package:realmbank_mobile/presentation/common/utils/extensions.dart';

class CardBackWidget extends StatelessWidget {
  const CardBackWidget({super.key, required this.user});
  final RMUser user;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: 275,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          colorFilter: ColorFilter.mode(
            Color.fromRGBO(0, 0, 0, 0.412),
            BlendMode.srcIn,
          ),
          image: AssetImage('assets/rmbg3-inv.png'),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.7),
            spreadRadius: 10,
            blurRadius: 50,
            offset: const Offset(0, 20),
          ),
        ],
        gradient: const LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Color.fromRGBO(0, 0, 0, 1),
            Color.fromRGBO(58, 58, 58, 1),
          ],
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 25, top: 36),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                  Text(
                    user.name.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  16.heightBox,
                  Text(
                    'Last Name',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                  Text(
                    user.lastName.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  16.heightBox,
                  Text(
                    'Card Number',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                  Text(
                    user.cardNumber.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: QrImageView(
              data: user.cardNumber,
              size: 200,
              dataModuleStyle: const QrDataModuleStyle(
                dataModuleShape: QrDataModuleShape.circle,
              ),
              eyeStyle: const QrEyeStyle(
                eyeShape: QrEyeShape.square,
                color: Colors.white,
              ),
              foregroundColor: Colors.grey.shade800.withOpacity(0.2),
            ),
          )
        ],
      ),
    );
  }
}
