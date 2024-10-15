import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:fluf/extensions/text_style_extensions.dart';
import 'package:flutter/material.dart';

const _drawSize = 24;
const _fallbackColor = Colors.transparent;

extension StringExtensions on String {
  ui.Paragraph toParagraph(TextStyle textStyle) {
    final builder = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        textAlign: TextAlign.center,
        fontSize: _drawSize.toDouble(),
      ),
    )..pushStyle(textStyle.toUiTextStyle());
    builder.addText(this);

    final paragraph = builder.build()
      ..layout(ui.ParagraphConstraints(width: _drawSize.toDouble()));

    return paragraph;
  }

  Future<Color> color(TextStyle textStyle) async {
    const size = _drawSize;
    final recorder = ui.PictureRecorder();

    Canvas(recorder)
      ..drawRect(
          Rect.fromPoints(
              Offset.zero, Offset(size.toDouble(), size.toDouble())),
          Paint()..color = Colors.white)
      ..drawParagraph(toParagraph(textStyle), Offset.zero);

    final ui.Image image = await recorder.endRecording().toImage(size, size);
    final bytes = await image.toByteData();
    final data = bytes?.buffer.asUint8List() ?? Uint8List(0);

    int r = 0, g = 0, b = 0, count = 0;
    const inc = 4;
    for (var x = 0; (x + inc) < data.length; x += inc) {
      if (data[x] != 255 && data[x + 1] != 255 && data[x + 2] != 255) {
        r += data[x];
        g += data[x + 1];
        b += data[x + 2];
        count++;
      }
    }

    if (count <= 0) {
      log("$this count = $count -> fallback will be used");
    }
    return count > 0
        ? Color.fromARGB(0, r ~/ count, g ~/ count, b ~/ count).withOpacity(1)
        : _fallbackColor;
  }
}
