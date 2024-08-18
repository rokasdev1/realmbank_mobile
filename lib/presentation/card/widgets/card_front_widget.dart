import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:realmbank_mobile/presentation/common/utils/extensions.dart';

class CardFrontWidget extends StatelessWidget {
  const CardFrontWidget({super.key, required this.fullName});
  final String fullName;

  @override
  Widget build(BuildContext context) {
    final formattedName = "${fullName[0]}. ${fullName.split(' ')[1]}";
    return Container(
      height: 400,
      width: 275,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          colorFilter: ColorFilter.mode(
            Color.fromRGBO(0, 0, 0, 0.412), // The color to blend with the image
            BlendMode.srcIn, // The blend mode to apply
          ),
          image: AssetImage('assets/rmbg3.png'),
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
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 16),
              child: Text(
                fullName.length > 16 ? formattedName : fullName,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 16, bottom: 16),
              child: SvgPicture.asset(
                'assets/realmlogo.svg',
                height: 35,
                width: 35,
                color: Colors.white,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/mc_debit.png',
                    height: 75,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Image.asset(
                      'assets/chip.png',
                      height: 50,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Image.asset(
                      'assets/nfc.png',
                      height: 35,
                      width: 35,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
