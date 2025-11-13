import 'dart:developer';
import 'dart:ui' as ui;

import 'package:fluf/extensions/text_style_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const _drawSize = 24.0;
const _fallbackColor = Colors.transparent;

extension StringExtensions on String {
  ClipboardData toClipboardData() => ClipboardData(text: this);

  Future<void> copyToClipboard() => Clipboard.setData(toClipboardData());

  Uri toUri() => Uri.parse(this);

  String captitalize() {
    return isEmpty ? this : "${this[0].toUpperCase()}${substring(1)}";
  }

  String captitalizeAll() {
    return isEmpty ? this : split(" ").map((e) => e.captitalize()).join(" ");
  }

  ui.Paragraph toParagraph(TextStyle textStyle) {
    final size = textStyle.fontSize;
    final builder = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        textAlign: TextAlign.center,
        fontSize: size,
      ),
    )..pushStyle(textStyle.toUiTextStyle());
    builder.addText(this);

    log("[fluf.StringExtensions.toParagraph] Layouting paragraph '$this'");

    final paragraph = builder.build()
      ..layout(ui.ParagraphConstraints(width: size ?? _drawSize));

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

    final picture = recorder.endRecording();

    final ui.Image image = await picture.toImage(
      size.toInt(),
      size.toInt(),
    );

    // Dispose picture ASAP to free native memory.
    picture.dispose();

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

    image.dispose();

    if (count <= 0) {
      log("$this count = $count -> fallback will be used");
    }

    return count > 0
        ? Color.fromARGB(0, r ~/ count, g ~/ count, b ~/ count).withAlpha(255)
        : _fallbackColor;
  }

  Size sizeOfStyle(TextStyle? style) {
    log("[fluf.StringExtensions.sizeOfStyle] Layouting paragraph '$this'");

    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: this, style: style),
      textDirection: TextDirection.ltr,
    )..layout();

    return textPainter.size;
  }

  String splitUpperCase({String delimiter = " "}) {
    if (isEmpty) return this;
    return replaceAllMapped(
      RegExp('(?<!$delimiter)(?<!^)[A-Z]'),
      (match) => "$delimiter${match.group(0)}",
    );
  }
}
