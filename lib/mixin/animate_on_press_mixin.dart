import 'package:flutter/material.dart';

const double _origin = 1.0;

mixin AnimateOnPressMixin<T extends StatefulWidget> on State<T> {
  abstract double animationTarget;

  double _value = _origin;
  double get animationValue => _value;

  void press() {
    _value = animationTarget;
    _pressed();
  }

  void release() {
    _value = _origin;
    _released();
  }

  void _pressed() => setState(() {});
  void _released() => setState(() {});
}
