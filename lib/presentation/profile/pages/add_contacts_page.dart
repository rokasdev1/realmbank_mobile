import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:realmbank_mobile/common/router.dart';
import 'package:realmbank_mobile/data/enums/toast_type.dart';
import 'package:realmbank_mobile/data/models/contact.dart';
import 'package:realmbank_mobile/data/models/user.dart';
import 'package:realmbank_mobile/main.dart';
import 'package:realmbank_mobile/presentation/common/providers/user_cubit.dart';
import 'package:realmbank_mobile/presentation/common/utils/extensions.dart';
import 'package:realmbank_mobile/presentation/common/utils/formatters.dart';
import 'package:realmbank_mobile/presentation/common/utils/message_toaster.dart';
import 'package:realmbank_mobile/presentation/common/widgets/big_button.dart';
import 'package:realmbank_mobile/presentation/common/widgets/text_field_widget.dart';
import 'package:realmbank_mobile/presentation/profile/widgets/add_user_field.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({super.key});

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  final cardNumController = TextEditingController();
  String searchValue = '';
  List<RMUser> users = [];
  final contactsBox = Hive.box<Contact>('contacts');

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      users = await context.read<UserCubit>().getUsers();
      await Future.delayed(const Duration(milliseconds: 500));
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add',
        ),
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is! SuccessUserState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final user = state.user;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    16.heightBox,
                    const Text(
                      'Add contact',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    16.heightBox,
                    AddUserField(
                      controller: cardNumController,
                      users: users,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 25,
                  ),
                  child: BigButton(
                    label: 'Add Contact',
                    onTap: () async {
                      if (matchingUser == null) {
                        return;
                      }
                      if (matchingUser!.uid == user.uid) {
                        MessageToaster.showMessage(
                          message: 'Cannot add yourself to contacts',
                          toastType: ToastType.error,
                        );
                        return;
                      }
                      final contact = Contact(
                        fullName: Formatters.fullName(
                            matchingUser!.name, matchingUser!.lastName),
                        cardNumber: matchingUser!.cardNumber,
                      );
                      if (contactsBox.values.any((element) =>
                          element.cardNumber == contact.cardNumber)) {
                        MessageToaster.showMessage(
                          message: 'Contact already exists',
                          toastType: ToastType.error,
                        );
                        return;
                      }
                      final key = await contactsBox.add(contact);
                      contact.key = key;
                      contactsBox.put(key, contact);
                      context.pop();
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
