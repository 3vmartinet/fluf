import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

const _drawSize = 24;
const _fallbackColor = Colors.transparent;

extension StringExtensions on String {
  ui.Paragraph toParagraph() {
    final builder = ui.ParagraphBuilder(ui.ParagraphStyle(
        textAlign: TextAlign.center, fontSize: _drawSize.toDouble()));
    builder.addText(this);

    final paragraph = builder.build()
      ..layout(const ui.ParagraphConstraints(width: 0));

    return paragraph;
  }

  Future<Color> color() async {
    const size = _drawSize;
    final recorder = ui.PictureRecorder();

    Canvas(recorder)
      ..drawRect(
          Rect.fromPoints(
              Offset.zero, Offset(size.toDouble(), size.toDouble())),
          Paint()..color = Colors.white)
      ..drawParagraph(toParagraph(), Offset.zero);

    final ui.Image image = await recorder.endRecording().toImage(size, size);
    final bytes =
        await image.toByteData(format: ui.ImageByteFormat.rawStraightRgba);
    final data = bytes?.buffer.asUint8List() ?? Uint8List(0);

    int r = 0, g = 0, b = 0, count = 0;

    for (var x = 0; x < data.length; x += 4) {
      if (data[x] != 255 && data[x + 1] != 255 && data[x + 2] != 255) {
        r += data[x];
        g += data[x + 1];
        b += data[x + 2];
        count++;
      }
    }

    return count > 0
        ? Color.fromARGB(0, r ~/ count, g ~/ count, b ~/ count).withOpacity(1)
        : _fallbackColor;
  }
}
