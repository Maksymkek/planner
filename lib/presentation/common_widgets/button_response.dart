import 'package:flutter/material.dart';

class ButtonResponseWidget extends StatefulWidget {
  const ButtonResponseWidget(
      {super.key, required this.onPressed, required this.child});

  final VoidCallback onPressed;
  final Widget child;

  @override
  State<ButtonResponseWidget> createState() => _ButtonResponseWidgetState();
}

class _ButtonResponseWidgetState extends State<ButtonResponseWidget>
    with SingleTickerProviderStateMixin {
  late final Animation<Color?> colorAnimation;
  late final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onPressed();
        controller.forward().whenComplete(() => controller.reverse());
      },
      onTapDown: (details) {
        controller.forward();
      },
      onTapCancel: () {
        controller.reverse();
      },
      child: widget.child,
    );
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 0),
      vsync: this,
      reverseDuration: const Duration(milliseconds: 600),
    );
    colorAnimation = ColorTween(
            begin: Colors.transparent, end: Colors.black.withOpacity(0.4))
        .animate(controller);
    colorAnimation.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}
