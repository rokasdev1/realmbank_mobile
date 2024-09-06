import 'package:flutter/material.dart';
import 'package:realmbank_mobile/presentation/auth/pages/intro_page.dart';
import 'package:realmbank_mobile/presentation/common/utils/extensions.dart';

class ListTileWidget extends StatelessWidget {
  final IconData leading;
  final String text;
  final Color? foregroundColor;
  final Function()? onTap;
  final IconData? trailingIcon;
  final Widget? trailing;
  const ListTileWidget({
    super.key,
    required this.leading,
    required this.text,
    required this.onTap,
    this.trailingIcon,
    this.foregroundColor,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        onTap: onTap,
        leading: Icon(
          leading,
          size: 25,
          color: foregroundColor ?? context.colorScheme.primary,
        ),
        title: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: trailingIcon != null
            ? Icon(
                trailingIcon,
                size: 15,
                color: foregroundColor ?? context.colorScheme.primary,
              )
            : trailing);
  }
}
