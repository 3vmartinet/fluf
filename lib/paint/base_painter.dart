import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract class BasePainter extends CustomPainter {
  static double defaultPatternSize = 24.0;

  final double? animationOffset;

  const BasePainter({this.animationOffset});

  @override
  void paint(Canvas canvas, Size size) {
    if (!kIsWeb && Platform.isAndroid) {
      canvas.restore();
    }

    customPaint(canvas, size);

    if (!kIsWeb && Platform.isAndroid) {
      canvas.save();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  void customPaint(Canvas canvas, Size size);

  double get offset => animationOffset ?? 0;
}
