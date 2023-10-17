import 'package:flutter/cupertino.dart';

class PickerContainerWidget extends StatelessWidget {
  const PickerContainerWidget(
      {super.key,
      required this.child,
      required this.borderRadius,
      this.padding = const EdgeInsets.symmetric(horizontal: 10)});

  final BorderRadius borderRadius;
  final EdgeInsetsGeometry padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
          color: CupertinoColors.lightBackgroundGray,
          borderRadius: borderRadius),
      child: child,
    );
  }
}
