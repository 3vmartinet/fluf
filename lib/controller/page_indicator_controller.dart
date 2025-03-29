import 'package:fluf/extensions/page_controller_extensions.dart';
import 'package:flutter/material.dart';

class PageIndicatorController {
  final PageController main = PageController();
  final PageController indicator = PageController();

  PageIndicatorController() {
    main.addListener(() => indicator.jumpTo(main.offset));
  }

  void dispose() {
    indicator.dispose();
    main.dispose();
  }

  int get page => main.atomicPage;
}
