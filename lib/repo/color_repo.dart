import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:fluf/extensions/text_style_extensions.dart';
import 'package:flutter/material.dart';

class ColorRepo {
  Future<Color> colorOfEmoji(
    String emoji,
    TextStyle style, {
    int stride = 1,
    int drawSize = 48,
    Color background = Colors.white,
    Color fallback = Colors.white,
  }) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    canvas.drawRect(
      Rect.fromLTWH(0, 0, drawSize.toDouble(), drawSize.toDouble()),
      Paint()..color = background,
    );

    final para =
        ui.ParagraphBuilder(ui.ParagraphStyle(textAlign: TextAlign.left))
          ..pushStyle(style.toUiTextStyle())
          ..addText(emoji);

    final paragraph = para.build()
      ..layout(ui.ParagraphConstraints(width: drawSize.toDouble()));

    canvas.drawParagraph(paragraph, Offset.zero);

    final picture = recorder.endRecording();
    final ui.Image image = await picture.toImage(drawSize, drawSize);
    final byteData = await image.toByteData();
    final bytes = (byteData ?? ByteData(0)).buffer.asUint8List();

    int r = 0, g = 0, b = 0, count = 0;
    final bgr = (background.r * 255.0).round() & 0xff;
    final bgg = (background.g * 255.0).round() & 0xff;
    final bgb = (background.b * 255.0).round() & 0xff;

    for (int i = 0; i < bytes.length; i += 4 * stride) {
      final rr = bytes[i], gg = bytes[i + 1], bb = bytes[i + 2];

      if (bgr == rr && bgg == gg && bgb == bb) {
        continue;
      }

      r += rr;
      g += gg;
      b += bb;
      count++;
    }

    final Color result = (count > 0)
        ? Color.fromARGB(255, r ~/ count, g ~/ count, b ~/ count)
        : fallback;

    image.dispose();
    picture.dispose();

    return result;
  }
}
