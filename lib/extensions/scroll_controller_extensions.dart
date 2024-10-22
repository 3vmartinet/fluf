import 'package:flutter/widgets.dart';

extension ScrollControllerExtensions on ScrollController {
  double get progress =>
      position.hasContentDimensions ? offset / position.maxScrollExtent : 0;
}
