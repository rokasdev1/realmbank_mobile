import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:realmbank_mobile/data/enums/toast_type.dart';
import 'package:realmbank_mobile/data/models/user.dart';
import 'package:realmbank_mobile/presentation/common/providers/request_cubit.dart';
import 'package:realmbank_mobile/presentation/common/providers/transaction_cubit.dart';
import 'package:realmbank_mobile/presentation/common/utils/extensions.dart';
import 'package:realmbank_mobile/presentation/common/utils/find_user_utils.dart';
import 'package:realmbank_mobile/presentation/common/utils/message_toaster.dart';
import 'package:realmbank_mobile/presentation/common/widgets/big_button.dart';
import 'package:realmbank_mobile/presentation/common/widgets/text_field_widget.dart';

class SendMoneyPage extends StatefulWidget {
  const SendMoneyPage({
    super.key,
    required this.sender,
    required this.receiverCardNum,
    this.receiver,
    this.amount,
    this.description,
    this.isRequest,
    this.requestId,
  });
  final RMUser sender;
  final String receiverCardNum;
  final RMUser? receiver;
  final double? amount;
  final String? description;
  final bool? isRequest;
  final String? requestId;

  @override
  State<SendMoneyPage> createState() => _SendMoneyPageState();
}

class _SendMoneyPageState extends State<SendMoneyPage> {
  final cardNumController = TextEditingController();
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();
  bool isRequest = false;
  late bool canEdit;

  @override
  void initState() {
    isRequest = widget.isRequest ?? false;
    canEdit = isRequest ? false : true;
    if (widget.receiverCardNum != '') {
      cardNumController.text = widget.receiverCardNum.substring(2);
    }
    if (widget.receiver != null) {
      cardNumController.text = widget.receiver!.cardNumber.substring(2);
    }
    if (widget.amount != null) {
      amountController.text = widget.amount.toString();
    }
    if (widget.description != null) {
      descriptionController.text = widget.description!;
    }
    super.initState();
  }

  @override
  void dispose() {
    cardNumController.dispose();
    amountController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log(canEdit.toString());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Send',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.heightBox,
            Text(
              isRequest ? 'Request' : 'Send money',
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            36.heightBox,
            TextFieldWidget(
              canEdit: widget.receiverCardNum != '' ? false : canEdit,
              keyboardType: TextInputType.number,
              longerHintText: false,
              controller: cardNumController,
              prefixText: 'RM',
              label: 'Card number',
              icon: Icons.person_2_outlined,
            ),
            8.heightBox,
            TextFieldWidget(
              canEdit: canEdit,
              keyboardType: TextInputType.number,
              longerHintText: false,
              controller: amountController,
              label: 'Amount',
              icon: Icons.attach_money,
            ),
            8.heightBox,
            TextFieldWidget(
              canEdit: canEdit,
              longerHintText: false,
              controller: descriptionController,
              label: 'Description',
              icon: Icons.description_outlined,
            ),
            16.heightBox,
            BigButton(
              label: isRequest ? 'Accept Request' : 'Send',
              onTap: () async {
                var receiver = widget.receiver;
                if (widget.receiver == null) {
                  receiver =
                      await findUserWithCardNum('RM${cardNumController.text}');
                }
                if (receiver == null || receiver.uid == widget.sender.uid) {
                  MessageToaster.showMessage(
                    message: 'User not found',
                    toastType: ToastType.error,
                  );
                  return;
                }
                if (descriptionController.text.isEmpty) {
                  MessageToaster.showMessage(
                    message: 'Description cannot be empty',
                    toastType: ToastType.error,
                  );
                  return;
                }
                if (double.parse(amountController.text) <= 0 ||
                    amountController.text.isEmpty) {
                  MessageToaster.showMessage(
                    message: 'Amount must be greater than 0',
                    toastType: ToastType.error,
                  );
                  return;
                }
                context.read<TransactionCubit>().sendMoney(
                      sender: widget.sender,
                      receiver: receiver,
                      amount: double.parse(amountController.text),
                      description: descriptionController.text,
                    );
                if (isRequest && widget.requestId != null) {
                  context
                      .read<RequestCubit>()
                      .closeRequest(requestId: widget.requestId!);
                }
                context.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
