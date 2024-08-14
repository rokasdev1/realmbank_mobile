import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:realmbank_mobile/presentation/common/providers/user_cubit.dart';
import 'package:realmbank_mobile/presentation/common/utils/extensions.dart';
import 'package:realmbank_mobile/presentation/common/widgets/big_button.dart';
import 'package:realmbank_mobile/presentation/common/widgets/text_field_widget.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 80,
      ),
      body: BlocBuilder<UserCubit, UserState>(builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Welcome!',
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                ),
              ),
              36.heightBox,
              const Text(
                'Introduce yourself',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              16.heightBox,
              TextFieldwidget(
                controller: nameController,
                label: 'Name',
                icon: Icons.person_outline,
              ),
              16.heightBox,
              TextFieldwidget(
                controller: lastNameController,
                label: 'Last name',
                icon: Icons.person,
              ),
              36.heightBox,
              BigButton(
                label: 'Create account',
                onTap: () async {
                  await context.read<UserCubit>().createUserAccount(
                        name: nameController.text,
                        lastName: lastNameController.text,
                      );
                  context.go('/');
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
