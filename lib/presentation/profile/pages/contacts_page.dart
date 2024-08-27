import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:realmbank_mobile/common/routes.dart';
import 'package:realmbank_mobile/data/models/contact.dart';
import 'package:realmbank_mobile/presentation/auth/pages/intro_page.dart';
import 'package:realmbank_mobile/presentation/common/utils/extensions.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  var contactsBox = Hive.box<Contact>('contacts');
  var contacts = <Contact>[];

  @override
  void initState() {
    super.initState();

    contacts = contactsBox.values.toList();
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
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(contacts[index].fullName),
            subtitle: Text(contacts[index].cardNumber),
          );
        },
      ),
    );
  }
}
