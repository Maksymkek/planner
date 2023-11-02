import 'package:flutter/cupertino.dart';
import 'package:planner/app_colors.dart';

void showModalWindow(BuildContext context, Widget child, double height) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => Padding(
      padding: const EdgeInsets.all(15.0),
      child: SafeArea(
        top: true,
        child: Container(
            height: height,
            width: double.infinity,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                color: AppColors.light),
            child: child),
      ),
    ),
  );
}
