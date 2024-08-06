import 'package:flutter/material.dart';
import 'package:realmbank_mobile/models/transaction.dart';
import 'package:realmbank_mobile/models/user.dart';
import 'package:realmbank_mobile/utils/extensions.dart';
import 'package:realmbank_mobile/utils/find_user_utils.dart';
import 'package:realmbank_mobile/widgets/big_button.dart';
import 'package:realmbank_mobile/widgets/text_field_widget.dart';

class SendMoneyPage extends StatefulWidget {
  const SendMoneyPage({super.key, required this.sender});
  final UserClass sender;

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
                await sendMoney(
                  widget.sender,
                  await findUserWithCardNum(userController.text),
                  double.parse(amountController.text),
                  descriptionController.text,
                );
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
