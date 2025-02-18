import 'package:flutter/material.dart';

extension GlobalKeyExtensions on GlobalKey {
  Offset? get center {
    RenderBox? box = currentContext?.findRenderObject() as RenderBox?;

    if (box != null) {
      final Offset position = box.localToGlobal(Offset.zero);
      final Size size = box.size;

      return Offset(
        position.dx + size.width / 2,
        position.dy + size.height / 2,
      );
    }

    return null;
  }
}
