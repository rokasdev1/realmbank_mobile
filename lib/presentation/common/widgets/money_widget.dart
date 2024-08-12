import 'package:flutter/material.dart';
import 'package:realmbank_mobile/presentation/common/utils/extensions.dart';
import 'package:realmbank_mobile/presentation/common/utils/number_format.dart';

class MoneyWidget extends StatelessWidget {
  const MoneyWidget({super.key, required this.money});
  final double money;

  @override
  Widget build(BuildContext context) {
    final List parts = money.toStringAsFixed(2).split('.');
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text(
          "\$",
          style: TextStyle(
              fontSize: 48, fontWeight: FontWeight.w900, color: Colors.white),
        ),
        16.widthBox,
        Text(
          formatNumberWithCommas(parts[0]),
          style: const TextStyle(
              fontSize: 48, fontWeight: FontWeight.w900, color: Colors.white),
        ),
        Text(
          '.${parts[1]}',
          style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w900,
              height: 1.8,
              color: Colors.white),
        ),
      ],
    );
  }
}
