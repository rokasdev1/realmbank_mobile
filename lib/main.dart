import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:realmbank_mobile/common/router.dart';
import 'package:realmbank_mobile/common/routes.dart';
import 'package:realmbank_mobile/data/repositories/authentication_repository.dart';
import 'package:realmbank_mobile/data/repositories/user_repository.dart';
import 'package:realmbank_mobile/firebase_options.dart';
import 'package:realmbank_mobile/presentation/auth/auth.dart';
import 'package:realmbank_mobile/presentation/common/providers/auth_cubit.dart';
import 'package:realmbank_mobile/presentation/common/providers/user_cubit.dart';

late final RMRouter router;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final authenticationRepository = AuthenticationRepository();
  final userRepository = UserRepository();

  @override
  void initState() {
    router = RMRouter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) {
            final authCubit = AuthCubit(
                authenticationRepository: authenticationRepository, context: _);
            authCubit.init();
            return authCubit;
          },
        ),
        BlocProvider(
          create: (_) {
            final userCubit = UserCubit(userRepository: userRepository);

            return userCubit;
          },
        )
      ],
      child: BlocListener<AuthCubit, AuthState>(
        child: MaterialApp.router(
          color: Colors.white,
          theme: ThemeData(
            fontFamily: 'Inter',
            scaffoldBackgroundColor: Colors.white,
          ),
          routerConfig: router.router,
        ),
        listener: (context, state) {
          if (state is InitialAuthState) {
            router.go(StartPageRoute());
          } else if (state is SuccessAuthState) {
            router.go(MainPageRoute());
          }
        },
      ),
    );
  }
}
