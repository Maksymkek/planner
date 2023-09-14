import 'package:flutter/material.dart';
import 'package:planner/app_colors.dart';

class AppButtonWidget extends StatefulWidget {
  const AppButtonWidget({
    super.key,
    this.icon,
    this.text,
    required this.onPressed,
    this.iconSize = 22.0,
    this.color = AppColors.buttonBlue,
    this.textSize = 18.0,
    this.spacer = 5.0,
    this.textStyle,
  }) : assert(text != null || icon != null);

  final String? text;
  final VoidCallback onPressed;
  final IconData? icon;
  final double iconSize;
  final TextStyle? textStyle;
  final Color color;
  final double textSize;
  final double spacer;

  @override
  State<AppButtonWidget> createState() => _AppButtonWidgetState();
}

class _AppButtonWidgetState extends State<AppButtonWidget>
    with SingleTickerProviderStateMixin {
  late Animation<Color?> colorAnimation;

  late AnimationController controller;

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
      child: _buildButton(),
    );
  }

  Widget? _buildButton() {
    if (widget.text == null) {
      return Icon(
        widget.icon,
        size: widget.iconSize,
        color: colorAnimation.value,
      );
    }
    final text = Text(
      widget.text ?? '',
      maxLines: 1,
      textAlign: TextAlign.center,
      style: widget.textStyle?.copyWith(color: colorAnimation.value) ??
          TextStyle(
            fontSize: widget.textSize,
            color: colorAnimation.value,
            fontWeight: FontWeight.w600,
          ),
    );
    return widget.icon != null
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: widget.iconSize,
                color: colorAnimation.value,
              ),
              SizedBox(width: widget.spacer),
              text
            ],
          )
        : text;
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
            begin: widget.color,
            end: Color.alphaBlend(Colors.black.withOpacity(0.3), widget.color))
        .animate(controller);
    colorAnimation.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
