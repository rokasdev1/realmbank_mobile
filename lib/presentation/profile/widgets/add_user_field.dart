import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:realmbank_mobile/data/models/user.dart';
import 'package:realmbank_mobile/presentation/common/utils/extensions.dart';
import 'package:realmbank_mobile/presentation/common/utils/formatters.dart';
import 'package:realmbank_mobile/presentation/common/widgets/big_button.dart';
import 'package:realmbank_mobile/presentation/common/widgets/text_field_widget.dart';

class AddUserField extends StatefulWidget {
  const AddUserField({
    super.key,
    required this.controller,
    required this.users,
  });
  final TextEditingController controller;
  final List<RMUser>? users;

  @override
  State<AddUserField> createState() => _AddUserFieldState();
}

RMUser? matchingUser;

class _AddUserFieldState extends State<AddUserField> {
  @override
  void initState() {
    widget.controller.addListener(
      () {
        setState(() {
          matchingUser = null;
          matchingUser = widget.users
              ?.where(
                  (user) => user.cardNumber == 'RM${widget.controller.text}')
              .firstOrNull;
        });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFieldWidget(
          controller: widget.controller,
          label: 'Card Number',
          prefixText: 'RM',
          longerHintText: false,
          icon: Icons.credit_card,
          trailing: matchingUser != null
              ? Container(
                  padding: const EdgeInsets.all(4),
                  margin: const EdgeInsets.only(right: 8),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                  child: Icon(
                    size: 15,
                    Icons.check,
                    color: context.colorScheme.surface,
                  ),
                )
              : Container(
                  padding: const EdgeInsets.all(4),
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.colorScheme.surfaceContainer,
                  ),
                  child: Icon(
                    size: 15,
                    Icons.close,
                    color: context.colorScheme.surface,
                  ),
                ),
        ),
        8.heightBox,
        if (matchingUser != null)
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: context.colorScheme.surfaceContainer,
            ),
            child: ListTile(
              tileColor: Colors.transparent,
              title: Text(
                Formatters.fullName(matchingUser!.name, matchingUser!.lastName),
              ),
              subtitle: Text(matchingUser!.email),
            ),
          ),
      ],
    );
  }
}
