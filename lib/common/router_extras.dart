import 'package:flutter_zxing/flutter_zxing.dart';
import 'package:realmbank_mobile/data/models/user.dart';

class SendMoneyExtra {
  SendMoneyExtra({
    required this.user,
    required this.receiverCardNum,
    this.amount,
    this.description,
    this.canEdit,
  });
  final RMUser user;
  final String receiverCardNum;
  final double? amount;
  final String? description;
  final bool? canEdit;
}

class RequestMoneyExtra {
  RequestMoneyExtra({
    required this.user,
    required this.receiverCardNum,
  });
  final RMUser user;
  final String receiverCardNum;
}

class QrRouteExtra {
  QrRouteExtra({
    this.onRequestScan,
    this.onProfileScan,
  });
  final Function(List<String> info)? onRequestScan;
  final Function(String cardNum)? onProfileScan;
}
