import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:realmbank_mobile/common/router.dart';
import 'package:realmbank_mobile/common/routes.dart';
import 'package:realmbank_mobile/data/models/user.dart';
import 'package:realmbank_mobile/main.dart';
import 'package:realmbank_mobile/presentation/card/card_page.dart';
import 'package:realmbank_mobile/presentation/common/providers/user_cubit.dart';
import 'package:realmbank_mobile/presentation/home/home_page.dart';
import 'package:realmbank_mobile/presentation/profile/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            log(state.toString());
            if (state is SuccessUserState) {
              final user = state.user;
              return IndexedStack(
                index: _currentIndex,
                children: [
                  HomePage(user: user),
                  CardPage(user: user),
                  ProfilePage(user: user),
                ],
              );
            }
            // } else if (state is InitialUserState) {
            //   WidgetsBinding.instance.addPostFrameCallback((_) {
            //     context.go('/intro-page');
            //   });
            // }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 2,
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.grey.shade400,
          selectedItemColor: const Color.fromRGBO(94, 98, 239, 1),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.credit_card), label: 'Card'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline_rounded), label: 'Profile'),
          ],
          onTap: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
          currentIndex: _currentIndex,
        ));
  }
}
