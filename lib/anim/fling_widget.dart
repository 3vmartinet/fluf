import 'dart:math';

import 'package:fluf/anim/base_animated_widget.dart';
import 'package:fluf/extensions/box_constraints_extensions.dart';
import 'package:fluf/extensions/build_context_extensions.dart';
import 'package:fluf/extensions/object_scope_extensions.dart';
import 'package:fluf/future/future_holder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const _rotateAnimation = "rotateAnimation";

class FlingWidget extends BaseAnimatedWidget {
  const FlingWidget(
      {super.key,
      super.delay,
      super.interval,
      required super.duration,
      required super.child,
      this.onFlinged,
      this.flingOnTap = false,
      this.curve = Curves.easeInOut,
      this.rotationCount = 1,
      required super.futureHolder});

  final Function()? onFlinged;
  final bool flingOnTap;
  final Curve curve;
  final int rotationCount;

  @override
  Animations registerAnimations(AnimationController controller) => {
        _rotateAnimation: Tween(begin: 0.0, end: pi * 2 * rotationCount)
            .animate(CurvedAnimation(parent: controller, curve: curve))
      };

  @override
  void animate(AnimationController controller, FutureHolder holder) {
    if (!holder.isDisposed()) {
      holder.add(Future.sync(() => controller.reset()));
      holder.add(controller.fling(velocity: 5.0));
    }
  }

  @override
  void onAnimationCompleted(
      AnimationController controller, FutureHolder holder) {
    super.onAnimationCompleted(controller, holder);

    onFlinged?.call();

    interval?.let((duration) =>
        Future.delayed(duration, () => animate(controller, holder)));
  }

  @override
  Widget buildImpl(BuildContext context, AnimationController controller,
      Animations animations, FutureHolder futureHolder) {
    final callback = flingOnTap
        ? () {
            HapticFeedback.heavyImpact();
            animate(controller, futureHolder);
          }
        : null;

    return GestureDetector(
      onDoubleTap: callback,
      onTap: callback,
      child: LayoutBuilder(
        builder: (context, constraints) => AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              if (constraints.areMaxConstraintsValid()) {
                return Transform(
                    transform: Matrix4.rotationY(
                        animations[_rotateAnimation]?.value ?? 0.0),
                    origin: Offset(
                        constraints.maxWidth / 2, constraints.maxHeight / 2),
                    child: super.child);
              } else {
                return SizedBox.square(
                  dimension: 70,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text("🦄",
                          textAlign: TextAlign.center,
                          style: context.textTheme.displayLarge),
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }
}
