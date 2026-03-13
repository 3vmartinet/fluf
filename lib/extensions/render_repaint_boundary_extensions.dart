import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';

extension RenderRepaintBoundaryExtensions on RenderRepaintBoundary {
  Future<String> toFile({
    required String directoryPath,
    required String filename,
    ui.ImageByteFormat format = ui.ImageByteFormat.png,
    Uint8List Function(Uint8List)? customTransform,
    double pixelRatio = 1.0,
  }) async {
    final image = await toImage(pixelRatio: pixelRatio);
    final bytes = await image.toByteData(format: format);
    var buffer = bytes?.buffer.asUint8List() ?? Uint8List(0);

    if (customTransform != null) {
      buffer = customTransform(buffer);
    }

    final targetFile = File('$directoryPath/$filename');
    final output = await targetFile.writeAsBytes(buffer.toList(), flush: true);

    return output.path;
  }
}
