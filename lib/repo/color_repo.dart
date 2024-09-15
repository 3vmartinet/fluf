import 'dart:developer';

import 'package:fluf/extensions/string_extensions.dart';
import 'package:flutter/material.dart';

class ColorRepo {
  static final ColorRepo _instance = ColorRepo._init();
  ColorRepo._init();

  factory ColorRepo() => _instance;

  final Map<String, Color> _cache = {};

  Future compute(Characters emojis) async {
    for (final emoji in emojis) {
      if (!_cache.containsKey(emoji)) {
        _cache[emoji] = await emoji.color();
        log("Computed color for $emoji");
      }
    }
  }

  Color? get(String emoji) => _cache[emoji];
}
