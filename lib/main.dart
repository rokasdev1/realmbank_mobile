import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:realmbank_mobile/common/router.dart';
import 'package:realmbank_mobile/firebase_options.dart';
import 'package:realmbank_mobile/presentation/auth/auth.dart';

late final RMRouter router;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      theme: ThemeData(
        fontFamily: 'Inter',
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const Auth(),
    );
  }
}
