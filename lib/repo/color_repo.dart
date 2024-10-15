import 'dart:developer';

import 'package:fluf/extensions/string_extensions.dart';
import 'package:flutter/material.dart';

class ColorRepo {
  static final ColorRepo _instance = ColorRepo._init();
  ColorRepo._init();

  factory ColorRepo() => _instance;

  final Map<String, Color> _cache = {};

  Future compute({
    required Characters emojis,
    required TextStyle textStyle,
  }) async {
    for (final emoji in emojis) {
      if (!_cache.containsKey(emoji)) {
        final color = await emoji.color(textStyle);
        _cache[emoji] = color;
        log("Computed color for $emoji (${color.red} / ${color.green} / ${color.blue}})");
      }
    }
  }

  Color? get(String emoji) => _cache[emoji];
}
