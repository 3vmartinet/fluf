import 'dart:convert';

import 'package:flutter/services.dart';

class AssetRepo {
  AssetRepo();

  /// Decodes a JSON file located at [assetPath]
  Future<List<dynamic>> loadJsonList(String assetPath) async {
    String jsonString = await rootBundle.loadString(assetPath);
    List<dynamic> list = jsonDecode(jsonString);

    return list;
  }

  Future<String> readFile(String path) => rootBundle.loadString(path);
  Future<ByteData> readFileAsBytes(String path) => rootBundle.load(path);
}
