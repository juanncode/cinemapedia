import 'package:flutter/material.dart';

class FadeOutLeft extends StatefulWidget {
  final Widget child;
  const FadeOutLeft({super.key, required this.child});

  @override
  State<FadeOutLeft> createState() => _FadeOutLeftState();
}

class _FadeOutLeftState extends State<FadeOutLeft> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> moveLeft;
  late Animation<double> opacity;
  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    moveLeft = Tween(begin: 100.0, end: 0.0)
        .animate(CurvedAnimation(parent: controller, curve: const Interval(0, 1, curve: Curves.easeInOutSine)));
    opacity = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: controller, curve: const Interval(0, 1, curve: Curves.easeInOutSine)));

    controller.forward();
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
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(moveLeft.value, 0),
          child: Opacity(
            opacity: opacity.value,
            child: widget.child,
          ),
        );
      },
    );
  }
}
