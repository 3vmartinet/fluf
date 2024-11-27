import 'dart:math';

import 'package:flutter/material.dart';

class RayPainter extends CustomPainter {
  final double rotation;
  final Color color1;
  final Color color2;

  const RayPainter(
      {required this.rotation, required this.color1, required this.color2});

  @override
  void paint(Canvas canvas, Size size) {
    final double rayLength =
        sqrt(size.width * size.width + size.height * size.height) / 2;
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint();

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);

    for (int i = 0; i < 360; i += 10) {
      // Drawing colored spaces every 10 degrees
      paint.color = (i ~/ 10) % 2 == 0 ? color1 : color2;
      canvas.drawArc(
        Rect.fromCircle(center: const Offset(0, 0), radius: rayLength),
        i * pi / 180,
        10 * pi / 180, // 10-degree arc
        true,
        paint,
      );
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
