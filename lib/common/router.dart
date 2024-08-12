import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:realmbank_mobile/common/routes.dart';
import 'package:realmbank_mobile/data/models/transaction.dart';
import 'package:realmbank_mobile/data/models/user.dart';
import 'package:realmbank_mobile/presentation/auth/login_page.dart';
import 'package:realmbank_mobile/presentation/auth/register_page.dart';
import 'package:realmbank_mobile/presentation/auth/start_page.dart';
import 'package:realmbank_mobile/presentation/card/card_page.dart';
import 'package:realmbank_mobile/presentation/home/home_page.dart';
import 'package:realmbank_mobile/presentation/home/transaction_details_page.dart';
import 'package:realmbank_mobile/presentation/profile/profile_page.dart';
import 'package:realmbank_mobile/presentation/auth/intro_page.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final signInNavigatorKey = GlobalKey<NavigatorState>();
final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

class RMRouter {
  late final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    observers: [routeObserver],
    routes: [
      GoRoute(
        name: 'home',
        path: '/',
        builder: (context, state) {
          final user = state.extra! as RMUser;
          return HomePage(user: user);
        },
        routes: [
          GoRoute(
            name: 'transactionDetails',
            path: 'transaction',
            builder: (context, state) {
              final extra = state.extra! as RMTransaction;
              return TransactionDetailsPage(transaction: extra);
            },
          ),
        ],
      ),
      GoRoute(
        name: 'start',
        path: '/start',
        builder: (context, state) => const StartPage(),
      ),
      GoRoute(
        name: 'login',
        path: '/login',
        builder: (context, state) {
          final extra = state.extra! as Function();
          return LoginPage(onSwitch: extra);
        },
      ),
      GoRoute(
        name: 'register',
        path: '/register',
        builder: (context, state) {
          final extra = state.extra! as Function();
          return RegisterPage(onSwitch: extra);
        },
      ),
      GoRoute(
        name: 'cardPage',
        path: '/card-page',
        builder: (context, state) {
          final user = state.extra! as RMUser;
          return CardPage(user: user);
        },
      ),
      GoRoute(
        name: 'profile',
        path: '/profile',
        builder: (context, state) {
          final user = state.extra! as RMUser;
          return ProfilePage(user: user);
        },
      ),
      GoRoute(
        name: 'introPage',
        path: '/intro-page',
        builder: (context, state) => const IntroPage(),
      )
    ],
  );

  void goForced(String route) {
    router.go(
      route,
    );
  }

  void go(RMRoute route, {Map<String, String>? params, Object? extra}) {
    router.goNamed(
      route.name,
      pathParameters: params ?? route.params,
      queryParameters: route.queryParams ?? {},
      extra: extra ?? route.extra,
    );
  }

  Future<T?> push<T>(RMRoute route) async {
    return router.pushNamed<T>(
      route.name,
      pathParameters: route.params,
      queryParameters: route.queryParams ?? {},
      extra: route.extra,
    );
  }

  Future<T?> pushReplacement<T>(RMRoute route) async {
    return router.pushReplacementNamed<T>(
      route.name,
      pathParameters: route.params,
      queryParameters: route.queryParams ?? {},
      extra: route.extra,
    );
  }

  Future<T?> pushNamed<T>(
    String route, {
    Map<String, String>? params,
    Object? extra,
  }) async {
    return router.pushNamed<T>(
      route,
      pathParameters: params ?? {},
      extra: extra,
    );
  }

  String? get location =>
      context != null ? GoRouterState.of(context!).uri.toString() : null;

  BuildContext? get context =>
      router.routerDelegate.navigatorKey.currentContext;

  void pop<T extends Object?>([T? result]) {
    router.pop(result);
  }
}
