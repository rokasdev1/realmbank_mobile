import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:realmbank_mobile/data/models/user.dart';
import 'package:realmbank_mobile/presentation/common/utils/extensions.dart';
import 'package:realmbank_mobile/presentation/common/utils/full_name.dart';
import 'package:realmbank_mobile/presentation/common/widgets/money_widget.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({super.key, required this.user});
  final RMUser user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Color.fromRGBO(59, 65, 242, 1),
            Color.fromRGBO(92, 97, 248, 1),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/realmlogo.svg',
                    height: 35,
                    width: 35,
                    color: Colors.white,
                  ),
                  8.widthBox,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fullName(user.name, user.lastName),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        user.cardNumber,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: const Text(
                  'USD',
                  style: TextStyle(
                      color: Color.fromRGBO(94, 98, 239, 1),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          8.heightBox,
          Divider(
            color: Colors.white.withOpacity(0.5),
          ),
          36.heightBox,
          MoneyWidget(money: user.balance),
        ],
      ),
    );
  }
}
