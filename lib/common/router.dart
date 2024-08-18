import 'package:flutter/material.dart';
import 'package:flutter_zxing/flutter_zxing.dart';
import 'package:go_router/go_router.dart';
import 'package:realmbank_mobile/common/router_extras.dart';
import 'package:realmbank_mobile/common/routes.dart';
import 'package:realmbank_mobile/data/models/transaction.dart';
import 'package:realmbank_mobile/data/models/user.dart';
import 'package:realmbank_mobile/main_page.dart';
import 'package:realmbank_mobile/presentation/auth/pages/login_register.dart';
import 'package:realmbank_mobile/presentation/auth/pages/start_page.dart';
import 'package:realmbank_mobile/presentation/card/pages/qr_scan_page.dart';
import 'package:realmbank_mobile/presentation/card/pages/request_money_page.dart';
import 'package:realmbank_mobile/presentation/card/pages/send_money_page.dart';
import 'package:realmbank_mobile/presentation/home/pages/transaction_details_page.dart';
import 'package:realmbank_mobile/presentation/auth/pages/intro_page.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final signInNavigatorKey = GlobalKey<NavigatorState>();
final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

class RMRouter {
  late final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    observers: [routeObserver],
    initialLocation: '/',
    routes: [
      GoRoute(
        name: 'main',
        path: '/',
        builder: (context, state) {
          return const MainPage();
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
        name: 'loginRegister',
        path: '/login-register',
        builder: (context, state) {
          return const LoginOrRegister();
        },
      ),
      GoRoute(
        name: 'introPage',
        path: '/intro-page',
        builder: (context, state) => const IntroPage(),
      ),
      GoRoute(
        name: 'sendMoney',
        path: '/send-money',
        builder: (context, state) {
          final extra = state.extra! as SendMoneyExtra;
          return SendMoneyPage(
            sender: extra.user,
            receiverCardNum: extra.receiverCardNum,
            amount: extra.amount,
            description: extra.description,
            canEdit: extra.canEdit,
          );
        },
      ),
      GoRoute(
        name: 'requestMoney',
        path: '/request-money',
        builder: (context, state) {
          final extra = state.extra! as RequestMoneyExtra;
          return RequestMoneyPage(
            user: extra.user,
            receiverCardNum: extra.receiverCardNum,
          );
        },
      ),
      GoRoute(
        name: 'qrScan',
        path: '/qr-scan',
        builder: (context, state) {
          return const QrScanPage();
        },
      ),
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
