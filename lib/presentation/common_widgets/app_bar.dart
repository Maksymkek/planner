import 'package:flutter/cupertino.dart';
import 'package:planner/app_colors.dart';
import 'package:planner/presentation/common_widgets/app_button.dart';

CupertinoNavigationBar buildAppBar(BuildContext context,
    {bool withLeading = false, String leadingText = 'Back', Widget? action}) {
  Widget? leading;
  if (withLeading) {
    leading = AppButtonWidget(
        icon: CupertinoIcons.chevron_left,
        text: leadingText,
        iconSize: 26,
        textStyle: const TextStyle(fontSize: 20),
        spacer: 0,
        onPressed: () {
          Navigator.pop(context);
        });
  }
  return CupertinoNavigationBar(
    backgroundColor: AppColors.light.withOpacity(0.6),
    automaticallyImplyLeading: false,
    border: null,
    leading: leading,
    trailing: Padding(
      padding: const EdgeInsets.only(right: 0.0),
      child: action ??
          AppButtonWidget(
            iconSize: 30,
            icon: CupertinoIcons.ellipsis_circle,
            onPressed: () {},
          ),
    ),
  );
}
