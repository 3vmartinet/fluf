import 'dart:math';

import 'package:fluf/anim/base_animated_widget.dart';
import 'package:fluf/future/future_holder.dart';
import 'package:flutter/material.dart';

const _rotateKey = "rotateKey";
const _scaleKey = "scaleKey";
const _opacityKey = "opacityKey";
const _rotationCount = 1;

class RevealWidget extends BaseAnimatedWidget {
  const RevealWidget({
    super.key,
    super.delay,
    required super.child,
    required super.futureHolder,
    required super.duration,
  });

  @override
  Animations registerAnimations(AnimationController controller) => {
        _rotateKey: Tween(begin: 0.0, end: 2.0 * pi * _rotationCount).animate(
            CurvedAnimation(parent: controller, curve: Curves.decelerate)),
        _scaleKey: Tween(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: controller, curve: Curves.decelerate)),
        _opacityKey: Tween(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: controller, curve: Curves.decelerate)),
      };

  @override
  Widget buildImpl(
    BuildContext context,
    AnimationController controller,
    Animations animations,
    FutureHolder futureHolder,
  ) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) => Transform.rotate(
        angle: animations[_rotateKey]!.value,
        child: Transform.scale(
          scale: animations[_scaleKey]!.value,
          child: Opacity(
            opacity: animations[_opacityKey]!.value,
            child: super.child,
          ),
        ),
      ),
    );
  }
}
