import 'dart:developer';

import 'package:fluf/extensions/string_extensions.dart';
import 'package:flutter/material.dart';

mixin ColorRepoMixin {
  final Map<String, Color> _cache = {};

  Future compute({
    required Characters emojis,
    required TextStyle textStyle,
  }) async {
    for (final emoji in emojis) {
      if (!_cache.containsKey(emoji)) {
        final color = await emoji.color(textStyle);
        _cache[emoji] = color;
        log("Computed color for $emoji [${emoji.codeUnits}] (${color.r * 255} / ${color.g * 255} / ${color.b * 255}})");
      }
    }
  }

  Color? get(String emoji) => _cache[emoji];
}
