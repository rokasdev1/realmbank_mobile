import 'package:cloud_firestore/cloud_firestore.dart';

class Request {
  final String requestorUID;
  final String requesteeUID;
  final double amount;
  final String description;
  final String id;
  final Timestamp timestamp;

  Request(
      {required this.requestorUID,
      required this.requesteeUID,
      required this.amount,
      required this.description,
      required this.id,
      required this.timestamp});

  Map<String, dynamic> toJson() => {
        'requestorUID': requestorUID,
        'requesteeUID': requesteeUID,
        'amount': amount,
        'description': description,
        'id': id,
        'timestamp': timestamp
      };

  static Request fromJson(Map<String, dynamic> json) => Request(
      requestorUID: json['requestorUID'],
      requesteeUID: json['requesteeUID'],
      amount: json['amount'],
      description: json['description'],
      id: json['id'],
      timestamp: json['timestamp']);
}
