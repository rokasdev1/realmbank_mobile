import 'package:animated_flip_widget/animated_flip_widget.dart';
import 'package:flutter/material.dart';
import 'package:realmbank_mobile/common/router.dart';
import 'package:realmbank_mobile/common/routes.dart';
import 'package:realmbank_mobile/data/enums/toast_type.dart';
import 'package:realmbank_mobile/data/models/user.dart';
import 'package:realmbank_mobile/presentation/card/widgets/card_back_widget.dart';
import 'package:realmbank_mobile/presentation/card/widgets/card_front_widget.dart';
import 'package:realmbank_mobile/presentation/common/utils/extensions.dart';
import 'package:realmbank_mobile/presentation/common/utils/full_name.dart';
import 'package:realmbank_mobile/presentation/common/utils/message_toaster.dart';
import 'package:realmbank_mobile/presentation/common/widgets/big_button.dart';
import 'package:realmbank_mobile/presentation/common/widgets/tile_widget.dart';

class CardPage extends StatelessWidget {
  CardPage({super.key, required this.user});
  final RMUser user;
  final controller = FlipController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 75,
        title: const Text(
          'Card',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              16.heightBox,
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TileWidget(
                      icon: Icons.arrow_upward_rounded,
                      title: 'Send',
                      onTap: () {
                        SendMoneyRoute(user: user).push();
                      },
                    ),
                    TileWidget(
                      onTap: () {},
                      icon: Icons.arrow_downward_rounded,
                      title: 'Request',
                    ),
                    TileWidget(
                      onTap: () {},
                      icon: Icons.qr_code_rounded,
                      title: 'Send with QR',
                    ),
                  ],
                ),
              ),
              36.heightBox,
              Center(
                child: AnimatedFlipWidget(
                  flipDirection: FlipDirection.horizontal,
                  flipDuration: const Duration(milliseconds: 500),
                  front: CardFrontWidget(
                    fullName: fullName(user.name, user.lastName),
                  ),
                  back: CardBackWidget(
                    user: user,
                  ),
                  controller: controller,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
