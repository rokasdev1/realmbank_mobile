import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String dateConvert(Timestamp timestamp) {
  final date = timestamp.toDate();
  return DateFormat('H:m, MMMM d').format(date);
}
