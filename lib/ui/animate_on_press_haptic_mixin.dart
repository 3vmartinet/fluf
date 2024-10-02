import 'package:fluf/ui/animate_on_press_mixin.dart';
import 'package:flutter/services.dart';

mixin AnimateOnPressHapticMixin on AnimateOnPressMixin {
  @override
  void press() {
    super.press();
    HapticFeedback.lightImpact();
  }
}
