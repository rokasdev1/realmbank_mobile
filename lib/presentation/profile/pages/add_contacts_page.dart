import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:realmbank_mobile/presentation/common/utils/extensions.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({super.key});

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  final cardNumController = TextEditingController();
  String searchValue = '';
  final contactsBox = Hive.box('contacts');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.heightBox,
            const Text(
              'Add contact',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            16.heightBox,
          ],
        ),
      ),
    );
  }
}
