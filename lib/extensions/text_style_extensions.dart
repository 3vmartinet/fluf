import 'package:flutter/material.dart';

extension TextStyleExtensions on TextStyle {
  TextStyle? bold() => copyWith(fontWeight: FontWeight.bold);
}
