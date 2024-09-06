import 'package:realmbank_mobile/data/models/user.dart';

class SendMoneyExtra {
  SendMoneyExtra({
    this.sender,
    this.receiverCardNum,
    this.senderCardNum,
    this.receiver,
    this.amount,
    this.description,
    this.isRequest,
    this.requestId,
  });
  final RMUser? sender;
  final String? senderCardNum;
  final String? receiverCardNum;
  final RMUser? receiver;
  final double? amount;
  final String? description;
  final bool? isRequest;
  final String? requestId;
}

class RequestMoneyExtra {
  RequestMoneyExtra({
    required this.user,
    required this.cardNum,
    this.showQrOption = false,
  });
  final RMUser user;
  final String cardNum;
  bool showQrOption = false;
}

class QrRouteExtra {
  QrRouteExtra({
    this.onRequestScan,
    this.onProfileScan,
  });
  final Function(List<String> info)? onRequestScan;
  final Function(String cardNum)? onProfileScan;
}
