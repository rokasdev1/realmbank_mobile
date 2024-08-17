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
  const SendMoneyPage({super.key, required this.sender});
  final RMUser sender;

  @override
  State<SendMoneyPage> createState() => _SendMoneyPageState();
}

class _SendMoneyPageState extends State<SendMoneyPage> {
  final userController = TextEditingController();
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    userController.dispose();
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
            TextFieldwidget(
              controller: userController,
              label: 'User',
              icon: Icons.person_2_outlined,
            ),
            8.heightBox,
            TextFieldwidget(
              controller: amountController,
              label: 'Amount',
              icon: Icons.attach_money,
            ),
            8.heightBox,
            TextFieldwidget(
              controller: descriptionController,
              label: 'Description',
              icon: Icons.description_outlined,
            ),
            16.heightBox,
            BigButton(
              label: 'Send',
              onTap: () async {
                final receiver = await findUserWithCardNum(userController.text);
                if (receiver == null) {
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
                if (double.parse(amountController.text) <= 0) {
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
