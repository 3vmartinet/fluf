import 'package:flutter/material.dart';

class ThemeRepo {
  static ThemeRepo? _instance;

  late final BuildContext _context;

  factory ThemeRepo({required BuildContext context}) =>
      _instance ?? ThemeRepo._init(context: context);

  ThemeRepo._init({required BuildContext context}) {
    _context = context;
  }

  ThemeData lightTheme() {
    return ThemeData.light(useMaterial3: true).copyWith();
  }

  ThemeData darkTheme() {
    return ThemeData.dark(useMaterial3: true).copyWith();
  }
}
