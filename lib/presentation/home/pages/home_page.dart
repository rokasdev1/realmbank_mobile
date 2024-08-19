import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:realmbank_mobile/data/models/user.dart';
import 'package:realmbank_mobile/presentation/common/utils/extensions.dart';
import 'package:realmbank_mobile/presentation/home/widgets/balance_card_widget.dart';
import 'package:realmbank_mobile/presentation/home/widgets/draggable_scroll_sheet.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.user});
  final RMUser user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey _columnKey = GlobalKey();
  double _columnHeight = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        setState(() {
          _columnHeight = _columnKey.currentContext?.size?.height ?? 0;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var sheetController = DraggableScrollableController();
    final today = DateTime.now();

    return LayoutBuilder(builder: (context, constraints) {
      double remainingHeight = constraints.maxHeight - _columnHeight;

      return Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            border:
                Border(top: BorderSide(color: Colors.grey.shade200, width: 2)),
            gradient: LinearGradient(colors: [
              Colors.grey.shade100,
              Colors.grey.shade600,
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
          child: Stack(
            children: [
              Column(
                key: _columnKey,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  36.heightBox,
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 16),
                    child: Text(
                      DateFormat(
                              "${DateFormat.WEEKDAY}, ${DateFormat.DAY} ${DateFormat.MONTH}")
                          .format(today),
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text(
                      'Account',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                    ),
                  ),
                  16.heightBox,
                  BalanceCardWidget(user: widget.user),
                  4.heightBox,
                ],
              ),
              SafeArea(
                child: DraggableScrollSheet(
                  sheetController: sheetController,
                  initialChildSize: remainingHeight / constraints.maxHeight,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
