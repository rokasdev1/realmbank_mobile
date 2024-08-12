import 'package:realmbank_mobile/data/models/transaction.dart';
import 'package:realmbank_mobile/data/models/user.dart';

abstract class RMRoute {
  const RMRoute({
    required this.name,
    required this.path,
    required this.params,
    this.queryParams,
    this.extra,
  });

  final String name;
  final String path;
  final Map<String, String> params;
  final Map<String, String>? queryParams;
  final Object? extra;
}

class StartPageRoute extends RMRoute {
  StartPageRoute()
      : super(
          name: 'start',
          path: '/start',
          params: {},
        );
}

class LoginRoute extends RMRoute {
  LoginRoute({
    required Function() onSwitch,
  }) : super(
          name: 'login',
          path: '/login',
          params: {},
          extra: onSwitch,
        );
}

class RegisterRoute extends RMRoute {
  RegisterRoute({
    required Function() onSwitch,
  }) : super(
          name: 'register',
          path: '/register',
          params: {},
          extra: onSwitch,
        );
}

class HomePageRoute extends RMRoute {
  HomePageRoute({
    required RMUser user,
  }) : super(
          name: 'home',
          path: '/',
          params: {},
          extra: user,
        );
}

class CardPageRoute extends RMRoute {
  CardPageRoute({
    required RMUser user,
  }) : super(
          name: 'cardPage',
          path: '/card-page',
          params: {},
          extra: user,
        );
}

class ProfilePageRoute extends RMRoute {
  ProfilePageRoute({
    required RMUser user,
  }) : super(
          name: 'profile',
          path: '/profile',
          params: {},
          extra: user,
        );
}

class TransactionDetailsRoute extends RMRoute {
  TransactionDetailsRoute({
    required RMTransaction transaction,
  }) : super(
          name: 'transactionDetails',
          path: 'transaction',
          params: {},
          extra: transaction,
        );
}

class IntroPageRoute extends RMRoute {
  IntroPageRoute()
      : super(
          name: 'introPage',
          path: '/intro-page',
          params: {},
        );
}
