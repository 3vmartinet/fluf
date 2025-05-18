import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';

extension RenderRepaintBoundaryExtensions on RenderRepaintBoundary {
  Future<String> toFile({
    required String directoryPath,
    required String filename,
  }) async {
    final image = await toImage();
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    final buffer = bytes?.buffer.asUint8List() ?? Uint8List(0);

    final targetFile = File('$directoryPath/$filename');
    final output = await targetFile.writeAsBytes(buffer.toList(), flush: true);

    return output.path;
  }
}
