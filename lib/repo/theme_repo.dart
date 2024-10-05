import 'package:flutter/material.dart';

class ThemeRepo {
  static ThemeRepo? _instance;

  factory ThemeRepo() => _instance ?? ThemeRepo._init();

  ThemeRepo._init() {
    _instance = this;
  }

  ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
    );
  }

  ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
    );
  }
}
