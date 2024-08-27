import 'package:realmbank_mobile/common/router_extras.dart';
import 'package:realmbank_mobile/data/models/transaction.dart';

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
  SendMoneyRoute({required SendMoneyExtra sendMoneyExtra})
      : super(
          name: 'sendMoney',
          path: '/send-money',
          params: {},
          extra: sendMoneyExtra,
        );
}

class RequestMoneyRoute extends RMRoute {
  RequestMoneyRoute({required RequestMoneyExtra requestMoneyExtra})
      : super(
          name: 'requestMoney',
          path: '/request-money',
          params: {},
          extra: requestMoneyExtra,
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

class QrScanRoute extends RMRoute {
  QrScanRoute()
      : super(
          name: 'qrScan',
          path: '/qr-scan',
          params: {},
        );
}

class RequestsRoute extends RMRoute {
  RequestsRoute()
      : super(
          name: 'requests',
          path: '/requests',
          params: {},
        );
}

class ContactsRoute extends RMRoute {
  ContactsRoute()
      : super(
          name: 'contacts',
          path: '/contacts',
          params: {},
        );
}

class AddContactRoute extends RMRoute {
  AddContactRoute()
      : super(
          name: 'addContact',
          path: '/add-contact',
          params: {},
        );
}

class AccountRoute extends RMRoute {
  AccountRoute()
      : super(
          name: 'account',
          path: '/account',
          params: {},
        );
}

class SettingsRoute extends RMRoute {
  SettingsRoute()
      : super(
          name: 'settings',
          path: '/settings',
          params: {},
        );
}
