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

  Widget toHero(Object? tag) {
    return tag != null ? Hero(tag: tag, child: this) : this;
  }

  Widget toMaterialHero(Object? tag) {
    return tag != null
        ? Hero(
            tag: tag,
            child: Material(color: Colors.transparent, child: this),
          )
        : this;
  }
}
