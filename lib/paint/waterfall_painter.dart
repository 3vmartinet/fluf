import 'package:fluf/extensions/string_extensions.dart';
import 'package:fluf/paint/base_painter.dart';
import 'package:flutter/material.dart';

const _defaultSpreadFactor = 1.5;

class WaterfallPainter extends BasePainter {
  final TextStyle style;
  final String emoji;
  final String? emoji2;
  final double? spreadFactor;

  const WaterfallPainter({
    required this.style,
    required this.emoji,
    super.animationOffset,
    this.emoji2,
    this.spreadFactor,
  });

  @override
  void customPaint(Canvas canvas, Size size) {
    double spread = spreadFactor ?? _defaultSpreadFactor;

    final patternSize = style.fontSize ?? BasePainter.defaultPatternSize;
    final int height = size.height.toInt() * 2;
    final int drawHeight = height;

    final countX = (size.width + patternSize) ~/ patternSize;
    final countY = drawHeight ~/ patternSize;

    for (int i = 0; i < countX; i++) {
      for (int j = 0; j < countY; j++) {
        final y = (j * patternSize + offset) % (countY * patternSize);
        final pattern = (i % 2 == 0 && j % 2 == 0) || (i % 2 == 1 && j % 2 == 1)
            ? emoji
            : (emoji2 ?? emoji);

        canvas.drawParagraph(
          pattern.toParagraph(style),
          Offset(
            i * patternSize * spread,
            y * spread - patternSize / 3,
          ),
        );
      }
    }
  }
}
