import 'package:cloud_firestore/cloud_firestore.dart';

String dateConvert(Timestamp timestamp) {
  final date = timestamp.toDate();
  return "${date.year}.${date.month}.${date.day} ${date.hour}:${date.minute}";
}
