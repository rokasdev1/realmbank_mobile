import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:realmbank_mobile/common/routes.dart';
import 'package:realmbank_mobile/presentation/common/utils/extensions.dart';
import 'package:realmbank_mobile/presentation/common/widgets/big_button.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 20,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/illustration.svg',
                height: MediaQuery.of(context).size.height * 0.5,
                fit: BoxFit.cover,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  text: 'Find the \n',
                  style: TextStyle(
                      fontSize: 50, fontWeight: FontWeight.bold, height: 1.3),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'right ',
                    ),
                    TextSpan(
                      text: 'bank',
                      style: TextStyle(
                        color: Color.fromRGBO(94, 98, 239, 1),
                      ),
                    ),
                  ],
                ),
              ),
              16.heightBox,
              Text(
                'Send and receive money right now with the fastest bank to date.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: BigButton(
                  label: "Let's started",
                  onTap: () {
                    LoginRegisterRoute().push();
                  },
                ),
              ),
              36.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
