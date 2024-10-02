import 'package:flutter/material.dart';

class ThemeRepo {
  static ThemeRepo? _instance;

  factory ThemeRepo() => _instance ?? ThemeRepo._init();

  ThemeRepo._init() {
    _instance = this;
  }

  ThemeData lightTheme() {
    return ThemeData.light(useMaterial3: true).copyWith();
  }

  ThemeData darkTheme() {
    return ThemeData.dark(useMaterial3: true).copyWith();
  }
}
