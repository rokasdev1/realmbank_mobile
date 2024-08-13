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

class LoginRegisterRoute extends RMRoute {
  LoginRegisterRoute()
      : super(
          name: 'loginRegister',
          path: '/login-register',
          params: {},
        );
}

class MainPageRoute extends RMRoute {
  MainPageRoute()
      : super(
          name: 'main',
          path: '/',
          params: {},
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

class SendMoneyRoute extends RMRoute {
  SendMoneyRoute({
    required RMUser user,
  }) : super(
          name: 'sendMoney',
          path: 'send-money',
          params: {},
          extra: user,
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
