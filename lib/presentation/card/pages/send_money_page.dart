import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:realmbank_mobile/data/enums/toast_type.dart';
import 'package:realmbank_mobile/data/models/user.dart';
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
    this.amount,
    this.description,
    this.canEdit,
  });
  final RMUser sender;
  final String receiverCardNum;
  final double? amount;
  final String? description;
  final bool? canEdit;

  @override
  State<SendMoneyPage> createState() => _SendMoneyPageState();
}

class _SendMoneyPageState extends State<SendMoneyPage> {
  final cardNumController = TextEditingController();
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    if (widget.receiverCardNum != '') {
      cardNumController.text = widget.receiverCardNum.substring(2);
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
            const Text(
              'Send money',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            36.heightBox,
            TextFieldWidget(
              canEdit: widget.canEdit,
              keyboardType: TextInputType.number,
              longerHintText: false,
              controller: cardNumController,
              prefixText: 'RM',
              label: 'Card number',
              icon: Icons.person_2_outlined,
            ),
            8.heightBox,
            TextFieldWidget(
              canEdit: widget.canEdit,
              keyboardType: TextInputType.number,
              longerHintText: false,
              controller: amountController,
              label: 'Amount',
              icon: Icons.attach_money,
            ),
            8.heightBox,
            TextFieldWidget(
              canEdit: widget.canEdit,
              longerHintText: false,
              controller: descriptionController,
              label: 'Description',
              icon: Icons.description_outlined,
            ),
            16.heightBox,
            BigButton(
              label: 'Send',
              onTap: () async {
                final receiver =
                    await findUserWithCardNum('RM${cardNumController.text}');
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
                context.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
