import 'package:flutter/material.dart';

class SlidableActionWidget extends StatefulWidget {
  const SlidableActionWidget(
      {super.key,
      required this.icon,
      required this.color,
      required this.onPressed,
      this.iconSize = 22});

  final Color color;
  final IconData icon;
  final double iconSize;
  final VoidCallback onPressed;

  @override
  State<SlidableActionWidget> createState() => _SlidableActionWidgetState();
}

class _SlidableActionWidgetState extends State<SlidableActionWidget>
    with SingleTickerProviderStateMixin {
  late Animation<Color?> animation;
  late AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return OverflowBox(
            alignment: Alignment.topRight,
            maxWidth: constraints.maxWidth,
            child: GestureDetector(
              onTap: () {
                controller.forward().whenComplete(() => controller.reverse());
                widget.onPressed();
              },
              onTapDown: (details) {
                controller.forward();
              },
              onTapCancel: () {
                controller.reverse();
              },
              child: ColoredBox(
                color: animation.value ?? Colors.grey,
                child: Align(
                  alignment: Alignment.center,
                  child: Icon(
                    widget.icon,
                    size: widget.iconSize,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 50),
      vsync: this,
      reverseDuration: const Duration(milliseconds: 250),
    );
    animation = ColorTween(
            begin: widget.color,
            end: Color.alphaBlend(Colors.white.withOpacity(0.5), widget.color))
        .animate(controller);

    animation.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
