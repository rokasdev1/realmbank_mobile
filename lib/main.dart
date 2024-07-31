import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:realmbank_mobile/firebase_options.dart';
import 'package:realmbank_mobile/page_redirectors/auth.dart';
import 'package:realmbank_mobile/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env");

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
