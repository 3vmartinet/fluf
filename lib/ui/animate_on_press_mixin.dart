import 'package:flutter/material.dart';

const double _origin = 1.0;

mixin AnimateOnPressMixin<T extends StatefulWidget> on State<T> {
  abstract double target;

  double _value = _origin;
  double get value => _value;

  void press() {
    _value = target;
    _pressed();
  }

  void release() {
    _value = _origin;
    _released();
  }

  void _pressed() => setState(() {});
  void _released() => setState(() {});
}
