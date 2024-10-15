import 'dart:ui' as ui;

import 'package:flutter/material.dart';

extension TextStyleExtensions on TextStyle {
  TextStyle? bold() => copyWith(fontWeight: FontWeight.bold);

  ui.TextStyle toUiTextStyle() {
    return ui.TextStyle(
      color: color,
      fontFamily: fontFamily,
      fontFamilyFallback: fontFamilyFallback,
      fontFeatures: fontFeatures,
      fontVariations: fontVariations,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      height: height,
      foreground: foreground,
      background: background,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      leadingDistribution: leadingDistribution,
      locale: locale,
      shadows: shadows,
      textBaseline: textBaseline,
    );
  }
}
