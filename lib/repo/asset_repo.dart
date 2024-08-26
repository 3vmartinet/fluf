import 'dart:convert';

import 'package:flutter/services.dart';

class AssetRepo {
  static AssetRepo? _instance;

  factory AssetRepo() => _instance ?? AssetRepo._init();

  AssetRepo._init();

  /// Decodes a JSON file located at [assetPath]
  Future<List<dynamic>> loadJsonList(String assetPath) async {
    String jsonString = await rootBundle.loadString(assetPath);
    List<dynamic> list = jsonDecode(jsonString);

    return list;
  }
}
