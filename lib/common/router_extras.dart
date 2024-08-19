import 'package:realmbank_mobile/data/models/user.dart';

class SendMoneyExtra {
  SendMoneyExtra({
    required this.sender,
    required this.receiverCardNum,
    this.receiver,
    this.amount,
    this.description,
    this.isRequest,
    this.requestId,
  });
  final RMUser sender;
  final String receiverCardNum;
  final RMUser? receiver;
  final double? amount;
  final String? description;
  final bool? isRequest;
  final String? requestId;
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
