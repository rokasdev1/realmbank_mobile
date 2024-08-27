import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:realmbank_mobile/common/router.dart';
import 'package:realmbank_mobile/common/routes.dart';
import 'package:realmbank_mobile/data/models/contact.dart';
import 'package:realmbank_mobile/data/repositories/authentication_repository.dart';
import 'package:realmbank_mobile/data/repositories/request_repository.dart';
import 'package:realmbank_mobile/data/repositories/transaction_repository.dart';
import 'package:realmbank_mobile/data/repositories/user_repository.dart';
import 'package:realmbank_mobile/firebase_options.dart';
import 'package:realmbank_mobile/presentation/common/providers/auth_cubit.dart';
import 'package:realmbank_mobile/presentation/common/providers/request_cubit.dart';
import 'package:realmbank_mobile/presentation/common/providers/theme_cubit.dart';
import 'package:realmbank_mobile/presentation/common/providers/transaction_cubit.dart';
import 'package:realmbank_mobile/presentation/common/providers/user_cubit.dart';
import 'package:realmbank_mobile/presentation/common/utils/theme.dart';

late final RMRouter router;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(ContactAdapter());

  Hive.initFlutter();
  await Hive.openBox<Contact>('contacts');
  await Hive.openBox('settings');

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
  final requestRepository = RequestRepository();

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
            final themeCubit = ThemeCubit();
            themeCubit.init();
            return themeCubit;
          },
        ),
        BlocProvider(
          create: (_) {
            final requestCubit =
                RequestCubit(requestRepository: requestRepository);
            return requestCubit;
          },
        ),
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
            final requestCubit = _.read<RequestCubit>();
            final userCubit = UserCubit(
                requestCubit: requestCubit,
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
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          final isDarkTheme = state is DarkThemeState;
          return MaterialApp.router(
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
            color: Colors.white,
            theme: RMTheme.themeData(isDarkTheme),
            routerConfig: router.router,
          );
        },
      ),
    );
  }
}
