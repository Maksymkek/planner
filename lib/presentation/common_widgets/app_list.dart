import 'package:flutter/material.dart';

import 'app_shadow.dart';

class AppListWidget extends StatelessWidget {
  const AppListWidget({super.key, required this.children, this.edgeInsets});

  final List<Widget> children;
  final EdgeInsets? edgeInsets;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: edgeInsets,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: AppShadows.lightShadow,
          borderRadius: const BorderRadius.all(Radius.circular(16.0))),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}
