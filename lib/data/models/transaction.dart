import 'package:cloud_firestore/cloud_firestore.dart';

class RMTransaction {
  final String senderUID;
  final String senderFullName;
  final String receiverUID;
  final String receiverFullName;
  final String description;
  final double amount;
  final Timestamp date;
  final String id;

  RMTransaction({
    required this.senderUID,
    required this.senderFullName,
    required this.receiverUID,
    required this.receiverFullName,
    required this.description,
    required this.amount,
    required this.date,
    required this.id,
  });

  Map<String, dynamic> toJson() => {
        'senderUID': senderUID,
        'senderFullName': senderFullName,
        'receiverUID': receiverUID,
        'receiverFullName': receiverFullName,
        'description': description,
        'amount': amount,
        'date': date,
        'id': id,
      };

  static RMTransaction fromJson(Map<String, dynamic> json) => RMTransaction(
        senderUID: json['senderUID'],
        senderFullName: json['senderFullName'],
        receiverUID: json['receiverUID'],
        receiverFullName: json['receiverFullName'],
        description: json['description'],
        amount: json['amount'],
        date: json['date'],
        id: json['id'],
      );
}
