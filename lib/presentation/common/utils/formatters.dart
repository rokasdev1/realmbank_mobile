import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Formatters {
  static String fullName(String name, String lastName) {
    final firstName = name[0].toUpperCase() + name.substring(1);
    final surname = lastName[0].toUpperCase() + lastName.substring(1);

    return "$firstName $surname";
  }

  static String numberWithCommas(String number) {
    final double doubleNum = double.parse(number);
    final formatter = NumberFormat('#,##0');
    return formatter.format(doubleNum);
  }

  static String dateFormat(Timestamp timestamp) {
    final date = timestamp.toDate();
    return DateFormat('H:m, MMMM d').format(date);
  }
}
