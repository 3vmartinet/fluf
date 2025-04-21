import 'package:flutter/material.dart';

extension TimeOfDayExtensions on TimeOfDay {
  int get minutes => hour * 60 + minute;
}
