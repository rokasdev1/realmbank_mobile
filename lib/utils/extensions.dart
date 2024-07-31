import 'package:flutter/material.dart';

extension IntX on int {
  Duration get days => Duration(days: this);
  Widget get heightBox => SizedBox(height: toDouble());
  Duration get hours => Duration(hours: this);
  Duration get minutes => Duration(minutes: this);
  Duration get months => Duration(days: this * 30);
  Duration get seconds => Duration(seconds: this);
  Widget get widthBox => SizedBox(width: toDouble());
}
