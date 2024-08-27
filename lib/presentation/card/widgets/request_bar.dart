import 'package:flutter/material.dart';
import 'package:realmbank_mobile/presentation/common/utils/extensions.dart';

class RequestBar extends StatelessWidget {
  const RequestBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 3,
          color: context.colorScheme.surfaceContainer,
        ),
      ),
      child: const TabBar(
        dividerHeight: 0,
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        tabs: [
          Tab(text: 'Received'),
          Tab(text: 'Sent'),
        ],
      ),
    );
  }
}
