import 'package:flutter/material.dart';
import 'package:realmbank_mobile/presentation/common/utils/extensions.dart';
import 'package:realmbank_mobile/presentation/home/widgets/transactions_widget.dart';

// ignore: must_be_immutable
class DraggableScrollSheet extends StatefulWidget {
  DraggableScrollSheet(
      {super.key,
      required this.sheetController,
      required this.initialChildSize});
  DraggableScrollableController sheetController;
  final double initialChildSize;

  @override
  State<DraggableScrollSheet> createState() => _DraggableScrollSheetState();
}

class _DraggableScrollSheetState extends State<DraggableScrollSheet> {
  bool isClosed = true;

  @override
  void dispose() {
    widget.sheetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      controller: widget.sheetController,
      initialChildSize: widget.initialChildSize,
      minChildSize: widget.initialChildSize,
      snap: true,
      maxChildSize: 1,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.only(top: 25, left: 16, right: 16),
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: ListView(
            controller: scrollController,
            children: [
              Center(
                child: Container(
                  width: 48,
                  padding: const EdgeInsets.all(4),
                  decoration: ShapeDecoration(
                    color: context.colorScheme.surfaceBright,
                    shape: const StadiumBorder(),
                  ),
                ),
              ),
              Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      16.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Transactions',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          SheetExpandText(
                            controller: widget.sheetController,
                            initialChildSize: widget.initialChildSize,
                          ),
                        ],
                      ),
                      16.heightBox,
                      const TransactionsWidget(),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class SheetExpandText extends StatefulWidget {
  const SheetExpandText(
      {super.key, required this.controller, required this.initialChildSize});
  final DraggableScrollableController controller;
  final double initialChildSize;

  @override
  State<SheetExpandText> createState() => _SheetExpandTextState();
}

class _SheetExpandTextState extends State<SheetExpandText> {
  bool isClosed = true;
  String text = 'See more';

  @override
  void initState() {
    widget.controller.addListener(
      () {
        if (widget.controller.size == 1) {
          setState(() {
            isClosed == false;
            text = 'See less';
          });
        } else {
          setState(() {
            isClosed == true;
            text = 'See more';
          });
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        isClosed
            ? widget.controller.animateTo(1,
                duration: const Duration(milliseconds: 500),
                curve: Curves.decelerate)
            : widget.controller.animateTo(widget.initialChildSize,
                duration: const Duration(milliseconds: 500),
                curve: Curves.decelerate);
        setState(() {
          isClosed = !isClosed;
        });
      },
      child: Text(
        isClosed ? text : text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color.fromRGBO(94, 98, 239, 1),
        ),
      ),
    );
  }
}
