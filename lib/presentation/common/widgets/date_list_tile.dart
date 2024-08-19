import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:realmbank_mobile/presentation/common/utils/date_converter.dart';
import 'package:realmbank_mobile/presentation/common/utils/extensions.dart';

class DateListTile extends StatelessWidget {
  const DateListTile(
      {super.key,
      required this.onTap,
      required this.icon,
      required this.title,
      required this.trailing,
      required this.date});
  final VoidCallback onTap;
  final IconData icon;
  final String title;
  final Widget trailing;
  final Timestamp date;

  final accentColor = const Color.fromRGBO(94, 98, 239, 1);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey.shade100,
                  radius: 25,
                  child: Icon(
                    Icons.send_to_mobile,
                    color: accentColor,
                  ),
                ),
                16.widthBox,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      dateConvert(date),
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}
