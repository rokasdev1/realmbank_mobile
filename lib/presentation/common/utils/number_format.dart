import 'package:intl/intl.dart';

String formatNumberWithCommas(String number) {
  final double doubleNum = double.parse(number);
  final formatter = NumberFormat('#,##0');
  return formatter.format(doubleNum);
}
