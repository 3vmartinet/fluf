import 'package:flutter/material.dart';

extension WidgetExtensions on Widget {
  Widget addSemantics({
    required String label,
    String? hint,
    String? value,
  }) =>
      Semantics(
        label: label,
        hint: hint ?? label,
        value: value ?? label,
        child: this,
      );
}
