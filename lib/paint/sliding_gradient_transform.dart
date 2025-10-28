import 'package:flutter/rendering.dart';

Matrix4 _matrix4 = Matrix4.zero()..setIdentity();

class SlidingGradientTransform extends GradientTransform {
  final double slidePercent;

  const SlidingGradientTransform({required this.slidePercent});

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return _matrix4..setTranslationRaw(bounds.width * slidePercent, 0.0, 0.0);
  }
}
