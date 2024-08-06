import 'package:intl/intl.dart';

String formatNumberWithCommas(String number) {
  // Create a NumberFormat instance for formatting with commas and two decimal places
  final double doubleNum = double.parse(number);
  final formatter = NumberFormat('#,##0');
  return formatter.format(doubleNum);
}
