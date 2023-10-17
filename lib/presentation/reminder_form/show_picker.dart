import 'package:flutter/cupertino.dart';

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
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                color: CupertinoColors.systemBackground.resolveFrom(context)),
            child: child),
      ),
    ),
  );
}
