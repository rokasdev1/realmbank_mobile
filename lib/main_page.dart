import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:realmbank_mobile/presentation/card/pages/card_page.dart';
import 'package:realmbank_mobile/presentation/common/providers/transaction_cubit.dart';
import 'package:realmbank_mobile/presentation/common/providers/user_cubit.dart';
import 'package:realmbank_mobile/presentation/home/pages/home_page.dart';
import 'package:realmbank_mobile/presentation/profile/pages/profile_page.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

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
          } else if (state is IntroUserState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.go('/intro-page');
            });
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade200, blurRadius: 10, spreadRadius: 5)
          ],
        ),
        child: SalomonBottomBar(
          itemPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
          items: [
            SalomonBottomBarItem(
              selectedColor: const Color.fromRGBO(94, 98, 239, 1),
              icon: const Icon(Icons.home_outlined),
              activeIcon: const Icon(Icons.home),
              title: const Text('Home'),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.credit_card),
              title: const Text('Card'),
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.person_outline),
              activeIcon: const Icon(Icons.person),
              title: const Text('Profile'),
            ),
          ],
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
