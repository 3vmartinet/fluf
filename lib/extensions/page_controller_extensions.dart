import 'package:flutter/widgets.dart';

extension PageControllerExtensions on PageController {
  int get atomicPage => page?.round() ?? 0;
}
