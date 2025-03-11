import 'package:flutter/services.dart';

mixin HapticFeedbackMixin {
  Future<void> lightHapticFeedback() => HapticFeedback.lightImpact();
  Future<void> mediumHapticFeedback() => HapticFeedback.mediumImpact();
  Future<void> heavyHapticFeedback() => HapticFeedback.heavyImpact();
  Future<void> selectionHapticFeedback() => HapticFeedback.selectionClick();
  Future<void> vibrateFeedback() => HapticFeedback.vibrate();
}
