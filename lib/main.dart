import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realmbank_mobile/common/router.dart';
import 'package:realmbank_mobile/common/routes.dart';
import 'package:realmbank_mobile/data/repositories/authentication_repository.dart';
import 'package:realmbank_mobile/data/repositories/transaction_repository.dart';
import 'package:realmbank_mobile/data/repositories/user_repository.dart';
import 'package:realmbank_mobile/firebase_options.dart';
import 'package:realmbank_mobile/presentation/common/providers/auth_cubit.dart';
import 'package:realmbank_mobile/presentation/common/providers/transaction_cubit.dart';
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
  final transactionRepository = TransactionRepository();

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
            final transactionCubit =
                TransactionCubit(transactionRepository: transactionRepository);
            return transactionCubit;
          },
        ),
        BlocProvider(
          create: (_) {
            final transactionCubit = _.read<TransactionCubit>();
            final userCubit = UserCubit(
                userRepository: userRepository,
                transactionCubit: transactionCubit);
            return userCubit;
          },
        ),
        BlocProvider(
          create: (_) {
            final userCubit = _.read<UserCubit>();
            final authCubit = AuthCubit(
                authenticationRepository: authenticationRepository,
                userCubit: userCubit);
            authCubit.init();
            return authCubit;
          },
        ),
      ],
      child: MaterialApp.router(
        color: Colors.white,
        theme: ThemeData(
          fontFamily: 'Inter',
          scaffoldBackgroundColor: Colors.white,
        ),
        routerConfig: router.router,
        builder: (context, child) {
          return Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) {
                  return BlocListener<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is InitialAuthState) {
                        router.go(StartPageRoute());
                      } else if (state is SuccessAuthState) {
                        router.go(MainPageRoute());
                      }
                    },
                    child: child,
                  );
                },
              )
            ],
          );
        },
      ),
    );
  }
}
