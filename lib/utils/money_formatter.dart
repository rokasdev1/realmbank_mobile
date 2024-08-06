import 'package:realmbank_mobile/models/transaction.dart';

String moneyFormat(TransactionModel transaction, String currentUserUID) {
  if (transaction.senderUID == currentUserUID) {
    return '-${transaction.amount} EUR';
  } else if (transaction.receiverUID == currentUserUID) {
    return '+${transaction.amount} EUR';
  }
  return '';
}
