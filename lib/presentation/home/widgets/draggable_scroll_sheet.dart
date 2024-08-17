import 'package:flutter/material.dart';
import 'package:realmbank_mobile/presentation/common/utils/extensions.dart';
import 'package:realmbank_mobile/presentation/home/widgets/transactions_widget.dart';

class DraggableScrollSheet extends StatefulWidget {
  DraggableScrollSheet({super.key, required this.sheetController});
  DraggableScrollableController sheetController;

  @override
  State<DraggableScrollSheet> createState() => _DraggableScrollSheetState();
}

class _DraggableScrollSheetState extends State<DraggableScrollSheet> {
  bool isClosed = true;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      controller: widget.sheetController,
      initialChildSize: 0.62,
      minChildSize: 0.62,
      snap: true,
      maxChildSize: 1,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.only(top: 25, left: 16, right: 16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: ListView(
            controller: scrollController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Center(
                child: Container(
                  width: 48,
                  padding: const EdgeInsets.all(4),
                  decoration: ShapeDecoration(
                    color: Colors.grey.shade300,
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
                          GestureDetector(
                            onTap: () {
                              isClosed
                                  ? widget.sheetController.animateTo(1,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.decelerate)
                                  : widget.sheetController.animateTo(0.62,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.decelerate);
                              setState(() {
                                isClosed = !isClosed;
                              });
                            },
                            child: Text(
                              isClosed ? 'See more' : 'See less',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(94, 98, 239, 1),
                              ),
                            ),
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
