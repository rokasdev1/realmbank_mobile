import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:realmbank_mobile/common/router.dart';
import 'package:realmbank_mobile/data/enums/toast_type.dart';
import 'package:realmbank_mobile/presentation/common/providers/user_cubit.dart';
import 'package:realmbank_mobile/presentation/common/utils/extensions.dart';
import 'package:realmbank_mobile/presentation/common/utils/message_toaster.dart';
import 'package:realmbank_mobile/presentation/common/widgets/big_button.dart';
import 'package:realmbank_mobile/presentation/profile/widgets/editable_field.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    lastNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Account',
        ),
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is FailedUserState) {
            return Center(
              child: Text(state.message),
            );
          }

          if (state is SuccessUserState) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  16.heightBox,
                  const Text(
                    'My Account',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  16.heightBox,
                  EditableField(
                    editable: false,
                    text: state.user.email,
                    label: 'Email',
                    icon: Icons.email_outlined,
                  ),
                  16.heightBox,
                  EditableField(
                    editable: false,
                    text: state.user.cardNumber.substring(2),
                    label: 'Card Number',
                    prefixText: 'RM',
                    icon: Icons.credit_card,
                  ),
                  16.heightBox,
                  EditableField(
                    initialText: state.user.name,
                    controller: nameController,
                    label: 'Name',
                    icon: Icons.person_2_outlined,
                  ),
                  16.heightBox,
                  EditableField(
                    initialText: state.user.lastName,
                    controller: lastNameController,
                    label: 'Last Name',
                    icon: Icons.person_2,
                  ),
                  36.heightBox,
                  BigButton(
                    label: 'Save',
                    onTap: () {
                      if (nameController.text == state.user.name &&
                          lastNameController.text == state.user.lastName) {
                        MessageToaster.showMessage(
                          message: 'No changes were made',
                          toastType: ToastType.error,
                        );
                      } else if (nameController.text.isNotEmpty &&
                          lastNameController.text.isNotEmpty) {
                        context.read<UserCubit>().updateUser(
                              state.user.copyWith(
                                name: nameController.text,
                                lastName: lastNameController.text,
                              ),
                            );
                        context.pop();
                      }
                    },
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
