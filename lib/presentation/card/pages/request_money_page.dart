import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:realmbank_mobile/data/enums/toast_type.dart';
import 'package:realmbank_mobile/data/models/user.dart';
import 'package:realmbank_mobile/presentation/card/widgets/qr_dialog.dart';
import 'package:realmbank_mobile/presentation/common/providers/request_cubit.dart';
import 'package:realmbank_mobile/presentation/common/utils/extensions.dart';
import 'package:realmbank_mobile/presentation/common/utils/find_user_utils.dart';
import 'package:realmbank_mobile/presentation/common/utils/message_toaster.dart';
import 'package:realmbank_mobile/presentation/common/utils/qr_code_gen.dart';
import 'package:realmbank_mobile/presentation/common/widgets/big_button.dart';
import 'package:realmbank_mobile/presentation/common/widgets/text_field_widget.dart';

class RequestMoneyPage extends StatefulWidget {
  const RequestMoneyPage(
      {super.key, required this.user, required this.receiverCardNum});
  final RMUser user;
  final String receiverCardNum;

  @override
  State<RequestMoneyPage> createState() => _RequestMoneyPageState();
}

class _RequestMoneyPageState extends State<RequestMoneyPage> {
  final cardNumController = TextEditingController();
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();
  bool withQR = false;

  @override
  void initState() {
    if (widget.receiverCardNum != '') {
      cardNumController.text = widget.receiverCardNum.substring(2);
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
          'Request',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                16.heightBox,
                const Text(
                  'Request money',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                36.heightBox,
                if (withQR == false) ...[
                  TextFieldWidget(
                    keyboardType: TextInputType.number,
                    prefixText: 'RM',
                    topText: 'Request from',
                    longerHintText: false,
                    controller: cardNumController,
                    label: 'Card number',
                    icon: Icons.attach_money,
                  ),
                  8.heightBox,
                ],
                TextFieldWidget(
                  keyboardType: TextInputType.number,
                  longerHintText: false,
                  controller: amountController,
                  label: 'Amount',
                  icon: Icons.attach_money,
                ),
                8.heightBox,
                TextFieldWidget(
                  longerHintText: false,
                  controller: descriptionController,
                  label: 'Description',
                  icon: Icons.description_outlined,
                ),
                16.heightBox,
                withQR
                    ? BigButton(
                        label: 'Generate QR Code',
                        onTap: () async {
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
                          return showDialog(
                            context: context,
                            builder: (context) {
                              return QrDialog(
                                data: qrCodeGen(
                                  requestorCardNum: widget.user.cardNumber,
                                  amount: double.parse(amountController.text),
                                  description: descriptionController.text,
                                ),
                              );
                            },
                          );
                        },
                      )
                    : BigButton(
                        label: 'Send Request',
                        onTap: () async {
                          final user = await findUserWithCardNum(
                              'RM${cardNumController.text}');
                          if (user == null || user.uid == widget.user.uid) {
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
                          await context.read<RequestCubit>().sendRequest(
                                requestor: widget.user,
                                requestee: user,
                                amount: double.parse(amountController.text),
                                description: descriptionController.text,
                              );
                          context.pop();
                        },
                      ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: BigButton(
                label:
                    withQR ? 'Request directly instead' : 'Request via QR code',
                onTap: () {
                  setState(() {
                    withQR = !withQR;
                  });
                },
                inverted: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
