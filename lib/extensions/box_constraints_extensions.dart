import 'package:flutter/widgets.dart';

extension BoxConstraintsExtensions on BoxConstraints {
  bool areMaxConstraintsValid() => maxWidth.isFinite && maxHeight.isFinite;
  bool areMinConstraintsValid() => minWidth.isFinite && minHeight.isFinite;

  Offset getCenter() {
    if (areMaxConstraintsValid()) {
      return Offset(maxWidth / 2, maxHeight / 2);
    } else if (areMinConstraintsValid()) {
      return Offset(minWidth / 2, minHeight / 2);
    } else {
      return Offset.zero;
    }
  }
}
