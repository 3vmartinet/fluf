library fluf;

import 'package:fluf/ui/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

extension BuildContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;
  Locale get locale => Localizations.localeOf(this);
  NavigatorState get navigator => Navigator.of(this);
  Brightness get brightness => MediaQuery.platformBrightnessOf(this);
  bool get isDarkBrightness => brightness == Brightness.dark;
  Orientation get orientation => MediaQuery.orientationOf(this);
  Size get mediaQuerySize => MediaQuery.sizeOf(this);

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
    Widget widget, {
    bool? floating,
    AnimationStyle? animationStyle,
    ShapeBorder? shapeBorder,
    SnackBarAction? action,
    Duration duration = const Duration(seconds: 4),
  }) {
    return ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: widget,
        behavior: floating == true
            ? SnackBarBehavior.floating
            : SnackBarBehavior.fixed,
        shape: shapeBorder,
        action: action,
        duration: duration,
      ),
      snackBarAnimationStyle: animationStyle,
    );
  }

  void pop({Object? result}) {
    return navigator.pop(result);
  }

  Future slideTo({
    required Widget widget,
    Duration duration = const Duration(milliseconds: 500),
    Axis axis = Axis.horizontal,
    String? routeName,
  }) {
    return navigator.push(_buildSlideRoute(
      widget: widget,
      duration: duration,
      axis: axis,
      routeName: routeName,
    ));
  }

  Future revealFrom({
    required Widget widget,
    Duration duration = const Duration(milliseconds: 500),
    required Alignment alignment,
  }) {
    return navigator.push(_buildRevealRoute(
      widget: widget,
      duration: duration,
      alignment: alignment,
    ));
  }

  Future<void> fadeTo({
    required Widget widget,
    bool replace = true,
    Duration duration = const Duration(milliseconds: 900),
    String? routeName,
  }) {
    final route = _buildFadeRoute(
        widget: widget, duration: duration, routeName: routeName);

    if (replace) {
      return navigator.pushReplacement(route);
    } else {
      return navigator.push(route);
    }
  }

  Route _buildFadeRoute({
    required Widget widget,
    required Duration duration,
    String? routeName,
  }) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
      transitionDuration: duration,
      settings: routeName != null ? RouteSettings(name: routeName) : null,
    );
  }

  Route _buildSlideRoute({
    required Widget widget,
    required Duration duration,
    required Axis axis,
    String? routeName,
  }) {
    return PageRouteBuilder(
      settings: routeName != null ? RouteSettings(name: routeName) : null,
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final begin = axis == Axis.horizontal
            ? const Offset(1.0, 0.0)
            : const Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Route<Object?> _buildRevealRoute(
      {required Widget widget,
      required Duration duration,
      required Alignment alignment}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final begin = alignment;
        const end = Alignment.center;
        const curve = Curves.ease;

        final scaleAnimation = Tween<double>(begin: 0.1, end: 1.0).animate(
          CurvedAnimation(parent: animation, curve: curve),
        );

        final alignmentAnimation = Tween(begin: begin, end: end).animate(
          CurvedAnimation(parent: scaleAnimation, curve: curve),
        );

        return ScaleTransition(
          scale: scaleAnimation,
          alignment: alignmentAnimation.value,
          child: child,
        );
      },
    );
  }

  RenderRepaintBoundary? get renderRepaintBoundary =>
      findRenderObject() as RenderRepaintBoundary?;

  Breakpoint get breakpoint {
    final width = mediaQuerySize.width;

    if (width < Breakpoint.compact.maxWidth) {
      return Breakpoint.compact;
    } else if (width < Breakpoint.medium.maxWidth) {
      return Breakpoint.medium;
    } else if (width < Breakpoint.expanded.maxWidth) {
      return Breakpoint.expanded;
    } else if (width < Breakpoint.large.maxWidth) {
      return Breakpoint.large;
    } else {
      return Breakpoint.extraLarge;
    }
  }
}
