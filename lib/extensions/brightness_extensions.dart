import 'package:flutter/material.dart';

extension BrightnessExtensions on Brightness {
  bool get isDark => this == Brightness.dark;
}
