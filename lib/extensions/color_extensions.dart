import 'dart:math';

import 'package:flutter/widgets.dart';

extension ColorExtensions on Color {
  WidgetStateProperty<Color> asPressableProperty(
          {double pressedOpacity = 0.5}) =>
      _buildProperty(normal: this, pressed: applyOpacity(pressedOpacity));

  Color minusDelta(int delta) => _delta(delta, false);
  Color plusDelta(int delta) => _delta(delta, true);

  Color _delta(int delta, bool lighten) {
    int increaseByOrBound(int value, int plus) =>
        lighten ? min(255, value + plus) : max(0, value - delta);

    return withRed(increaseByOrBound((r * 255) ~/ 1, delta))
        .withGreen(increaseByOrBound((g * 255) ~/ 1, delta))
        .withBlue(increaseByOrBound((b * 255) ~/ 1, delta));
  }

  Color applyOpacity(double opacity) => withAlpha((opacity * 255) ~/ 1);

  WidgetStateProperty<T> _buildProperty<T>({
    required T normal,
    T? pressed,
    T? disabled,
  }) {
    return WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.pressed)) {
        return pressed ?? normal;
      } else if (states.contains(WidgetState.disabled)) {
        return disabled ?? normal;
      } else {
        return normal;
      }
    });
  }
}
