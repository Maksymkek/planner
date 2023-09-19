import 'package:flutter/cupertino.dart';
import 'package:planner/app_colors.dart';
import 'package:planner/presentation/common_widgets/app_button.dart';

CupertinoNavigationBar buildAppBar(BuildContext context,
    {bool withLeading = false}) {
  Widget? leading;
  if (withLeading) {
    leading = SizedBox(
      width: 90,
      height: 20,
      child: AppButtonWidget(
          icon: CupertinoIcons.chevron_left,
          text: 'Back',
          iconSize: 20,
          textStyle: const TextStyle(fontSize: 20),
          spacer: 2,
          onPressed: () {
            Navigator.pop(context);
          }),
    );
  }
  return CupertinoNavigationBar(
    backgroundColor: AppColors.light.withOpacity(0.6),
    automaticallyImplyLeading: false,
    border: null,
    leading: leading,
    trailing: Padding(
      padding: const EdgeInsets.only(right: 0.0),
      child: AppButtonWidget(
        iconSize: 30,
        icon: CupertinoIcons.ellipsis_circle,
        onPressed: () {},
      ),
    ),
  );
}
