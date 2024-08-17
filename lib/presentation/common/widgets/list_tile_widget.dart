import 'package:flutter/material.dart';

class ListTileWidget extends StatelessWidget {
  final IconData leading;
  final String text;
  final Color? foregroundColor;
  final Function()? onTap;
  final IconData? trailing;
  const ListTileWidget({
    super.key,
    required this.leading,
    required this.text,
    required this.onTap,
    this.trailing,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        onTap: onTap,
        leading: Icon(
          leading,
          size: 25,
          color: foregroundColor ?? const Color.fromRGBO(94, 98, 239, 1),
        ),
        title: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: trailing != null
            ? Icon(
                trailing,
                size: 15,
                color: foregroundColor ?? const Color.fromRGBO(94, 98, 239, 1),
              )
            : null);
  }
}
