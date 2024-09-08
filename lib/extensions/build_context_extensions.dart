library fluf;

import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;

  NavigatorState get navigator => Navigator.of(this);

  void pop() {
    return navigator.pop();
  }

  Future navigateTo(Widget widget) {
    return navigator.push(_buildRoute(
        widget: widget, duration: const Duration(milliseconds: 500)));
  }

  Future<void> fadeTo({
    required Widget widget,
    Duration duration = const Duration(milliseconds: 900),
  }) {
    return navigator
        .pushReplacement(_buildFadeRoute(widget: widget, duration: duration));
  }

  Route _buildFadeRoute({
    required Widget widget,
    required Duration duration,
  }) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
      transitionDuration: duration,
    );
  }

  Route _buildRoute({
    required Widget widget,
    required Duration duration,
  }) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween = Tween(begin: begin, end: end);
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      },
    );
  }
}
