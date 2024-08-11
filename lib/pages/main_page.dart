import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:realmbank_mobile/models/user.dart';
import 'package:realmbank_mobile/pages/card_page.dart';
import 'package:realmbank_mobile/pages/home_page.dart';
import 'package:realmbank_mobile/pages/profile_page.dart';

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
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final userData = snapshot.data!.data() as Map<String, dynamic>;
              final user = UserClass.fromJson(userData);
              return IndexedStack(
                index: _currentIndex,
                children: [
                  HomePage(user: user),
                  CardPage(user: user),
                  ProfilePage(user: user),
                ],
              );
            } else {
              return const Text('Error');
            }
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
