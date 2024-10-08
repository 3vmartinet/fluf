import 'package:fluf/extensions/object_scope_extensions.dart';
import 'package:fluf/future/future_holder.dart';
import 'package:flutter/material.dart';

typedef Animations = Map<String, Animation<double>>;

abstract class BaseAnimatedWidget extends StatefulWidget {
  const BaseAnimatedWidget(
      {super.key,
      required this.child,
      this.delay,
      this.interval,
      required this.duration,
      required this.futureHolder});

  @override
  State<BaseAnimatedWidget> createState() => BaseAnimatedWidgetState();

  Animations registerAnimations(AnimationController controller);
  Widget buildImpl(BuildContext context, AnimationController controller,
      Animations animations, FutureHolder futureHolder);

  void onAnimationCompleted(
      AnimationController controller, FutureHolder holder) {}

  void animate(AnimationController controller, FutureHolder holder) {
    holder.add(controller.forward());
  }

  final Widget child;
  final Duration? delay;
  final Duration? interval;
  final Duration? duration;
  final FutureHolder futureHolder;
}

class BaseAnimatedWidgetState extends State<BaseAnimatedWidget>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  final Animations _animations = {};

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.onAnimationCompleted(_controller, widget.futureHolder);
          widget.interval?.let((interval) {
            widget.futureHolder.add(Future.delayed(interval, animate));
          });
        }
      });

    _animations.addAll(widget.registerAnimations(_controller));

    widget.delay?.let(
        (delay) => widget.futureHolder.add(Future.delayed(delay, animate)));
  }

  @override
  void dispose() {
    widget.futureHolder.dispose();
    _controller.dispose();
    super.dispose();
  }

  void animate() {
    widget.animate(_controller, widget.futureHolder);
  }

  @override
  Widget build(BuildContext context) =>
      widget.buildImpl(context, _controller, _animations, widget.futureHolder);
}
