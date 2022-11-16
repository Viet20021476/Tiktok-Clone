import 'dart:math';

import 'package:flutter/material.dart';

class CircleAnimation extends StatefulWidget {
  final Widget child;

  const CircleAnimation({Key? key, required this.child}) : super(key: key);

  @override
  State<CircleAnimation> createState() => _CircleAnimationState();
}

class _CircleAnimationState extends State<CircleAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 5000));
    controller.forward();
    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: ((context, child) {
          return Transform.rotate(
            angle: 2 * pi * controller.value,
            child: child,
          );
        }),
        child: widget.child);
  }
}
