import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:realmbank_mobile/common/router.dart';
import 'package:realmbank_mobile/data/models/contact.dart';
import 'package:realmbank_mobile/data/models/user.dart';
import 'package:realmbank_mobile/main.dart';
import 'package:realmbank_mobile/presentation/common/providers/user_cubit.dart';
import 'package:realmbank_mobile/presentation/common/utils/extensions.dart';
import 'package:realmbank_mobile/presentation/common/utils/full_name.dart';
import 'package:realmbank_mobile/presentation/common/widgets/text_field_widget.dart';

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
        backgroundColor: Colors.white,
        title: const Text(
          'Add',
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
