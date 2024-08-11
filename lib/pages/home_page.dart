import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:realmbank_mobile/models/transaction.dart';
import 'package:realmbank_mobile/models/user.dart';
import 'package:realmbank_mobile/pages/send_money_page.dart';
import 'package:realmbank_mobile/utils/extensions.dart';
import 'package:realmbank_mobile/utils/full_name.dart';
import 'package:realmbank_mobile/widgets/big_button.dart';
import 'package:realmbank_mobile/widgets/card_widget.dart';
import 'package:realmbank_mobile/widgets/draggable_scroll_sheet.dart';
import 'package:realmbank_mobile/widgets/money_widget.dart';
import 'package:realmbank_mobile/widgets/transactions_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.user});
  final UserClass user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var sheetController = DraggableScrollableController();
    final today = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        toolbarHeight: 100,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat(
                      "${DateFormat.WEEKDAY}, ${DateFormat.DAY} ${DateFormat.MONTH}")
                  .format(today),
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const Text(
              'Account',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 16),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(color: Colors.grey.shade200, width: 2)),
              gradient: LinearGradient(colors: [
                Colors.grey.shade100,
                Colors.grey.shade600,
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
          ),
          CardWidget(user: widget.user),
          DraggableScrollSheet(sheetController: sheetController),
        ],
      ),
    );
  }
}
