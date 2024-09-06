import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:realmbank_mobile/common/router.dart';
import 'package:realmbank_mobile/common/router_extras.dart';
import 'package:realmbank_mobile/common/routes.dart';
import 'package:realmbank_mobile/data/models/contact.dart';
import 'package:realmbank_mobile/presentation/auth/pages/intro_page.dart';
import 'package:realmbank_mobile/presentation/common/providers/user_cubit.dart';
import 'package:realmbank_mobile/presentation/common/utils/extensions.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  var contactsBox = Hive.box<Contact>('contacts');

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Contacts',
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16, right: 16),
        child: FloatingActionButton(
          backgroundColor: context.colorScheme.primary,
          shape: const StadiumBorder(),
          onPressed: () {
            AddContactRoute().push();
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      body: BlocBuilder<UserCubit, UserState>(builder: (context, state) {
        if (state is! SuccessUserState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final user = state.user;
        return StreamBuilder<BoxEvent>(
            stream: contactsBox.watch(),
            builder: (context, snapshot) {
              var contacts = contactsBox.values.toList();

              return ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      contacts[index].fullName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(contacts[index].cardNumber),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(elevation: 10),
                          child: const Text('More'),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 36,
                                    vertical: 24,
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        contacts[index].fullName,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        contacts[index].cardNumber,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: context
                                              .colorScheme.onSurfaceVariant,
                                        ),
                                      ),
                                      25.heightBox,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                elevation: 10),
                                            child: const Text('Send'),
                                            onPressed: () {
                                              context.pop();
                                              SendMoneyRoute(
                                                sendMoneyExtra: SendMoneyExtra(
                                                  sender: user,
                                                  receiverCardNum:
                                                      contacts[index]
                                                          .cardNumber,
                                                ),
                                              ).push();
                                            },
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                elevation: 10),
                                            child: const Text('Receive'),
                                            onPressed: () {
                                              context.pop();
                                              RequestMoneyRoute(
                                                requestMoneyExtra:
                                                    RequestMoneyExtra(
                                                  user: user,
                                                  cardNum: contacts[index]
                                                      .cardNumber,
                                                  showQrOption: false,
                                                ),
                                              ).push();
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ),
                          onPressed: () {
                            contactsBox.delete(contacts[index].key);
                            contacts = contactsBox.values.toList();
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            });
      }),
    );
  }
}
