import 'package:flutter/widgets.dart';

extension ScrollControllerExtensions on ScrollController {
  double get progress {
    if (!hasClients) return 0;

    return position.hasContentDimensions
        ? offset / position.maxScrollExtent
        : 0;
  }
}
