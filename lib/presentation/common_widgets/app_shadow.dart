import 'package:flutter/cupertino.dart';

abstract final class AppShadows {
  static final lightShadow = [
    BoxShadow(
        color: CupertinoColors.black.withOpacity(0.015),
        blurRadius: 10,
        spreadRadius: 10)
  ];
  static final timerShadow = [
    BoxShadow(
        color: CupertinoColors.black.withOpacity(0.1),
        blurRadius: 3,
        spreadRadius: 0.5)
  ];
}
