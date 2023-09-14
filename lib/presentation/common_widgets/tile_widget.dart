import 'package:flutter/material.dart';
import 'package:planner/app_colors.dart';

class TileWidget extends StatefulWidget {
  const TileWidget({
    super.key,
    required this.icon,
    required this.background,
    required this.title,
    required this.trailing,
    required this.withDivider,
    required this.onPressed,
  });

  final Icon icon;
  final Color background;
  final String title;
  final Widget trailing;
  final bool withDivider;
  final VoidCallback onPressed;

  @override
  State<TileWidget> createState() => _TileWidgetState();
}

class _TileWidgetState extends State<TileWidget>
    with SingleTickerProviderStateMixin {
  late final Animation<Color?> animation;
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
      child: ColoredBox(
        color: animation.value ?? Colors.white,
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 4.5),
              child: Row(
                children: [
                  Container(
                    width: 34,
                    height: 32,
                    decoration: BoxDecoration(
                        color: widget.background,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8.0))),
                    child: widget.icon,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      widget.title,
                      maxLines: 1,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const Spacer(),
                  widget.trailing
                ],
              ),
            ),
            if (widget.withDivider)
              const Padding(
                padding: EdgeInsets.only(left: 67),
                child: Divider(
                  thickness: 0.5,
                  color: Colors.grey,
                  height: 0.5,
                ),
              )
          ],
        ),
      ),
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
    animation = ColorTween(begin: Colors.white, end: AppColors.lightToggledGrey)
        .animate(controller);
    animation.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}
