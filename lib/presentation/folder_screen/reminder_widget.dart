import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:planner/app_colors.dart';
import 'package:planner/domain/entity/reminder/reminder.dart';
import 'package:planner/presentation/common_widgets/slidable_widget.dart';
import 'package:planner/presentation/folder_screen/models/folder_model.dart';
import 'package:planner/presentation/folder_screen/reminder_content_widget.dart';
import 'package:planner/presentation/reminder_details_screen/reminder_details_screen.dart';
import 'package:planner/presentation/reminder_form/show_picker.dart';
import 'package:provider/provider.dart';

class ReminderWidget extends StatefulWidget {
  const ReminderWidget(
    this.reminder, {
    super.key,
  });

  final Reminder reminder;

  @override
  State<ReminderWidget> createState() => _ReminderWidgetState();
}

class _ReminderWidgetState extends State<ReminderWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<Color?> animation;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.4,
        motion: const DrawerMotion(),
        children: [
          SlidableActionWidget(
            onPressed: () {
              showModalWindow(
                  context,
                  ReminderDetailsScreen(reminder: widget.reminder),
                  double.infinity);
            },
            icon: CupertinoIcons.info_circle_fill,
            iconSize: 26,
            color: AppColors.lightBlue,
          ),
          SlidableActionWidget(
            onPressed: () {
              Provider.of<FolderModel>(context, listen: false)
                  .onDeleteReminderClick(widget.reminder);
            },
            icon: CupertinoIcons.delete_solid,
            iconSize: 26,
            color: CupertinoColors.destructiveRed,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 3),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                if (controller.isAnimating) {
                  controller.reverse();
                  return;
                }
                controller.forward().whenComplete(() {
                  controller.reverse();
                }).whenComplete(() =>
                    Provider.of<FolderModel>(context, listen: false)
                        .onUpdateReminderClick(widget.reminder));
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 4.5),
                child: buildToggleButton(),
              ),
            ),
            const SizedBox(width: 10),
            ReminderContentWidget(reminder: widget.reminder)
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 1),
        reverseDuration: const Duration(milliseconds: 500));
    animation = ColorTween(begin: AppColors.light, end: AppColors.darkGrey)
        .animate(controller);
    animation.addListener(() {
      setState(() {});
    });
  }

  Widget buildToggleButton() {
    return Container(
      width: 20,
      height: 20,
      padding: const EdgeInsets.all(1.5),
      decoration: BoxDecoration(
          color: AppColors.light,
          shape: BoxShape.circle,
          border: Border.all(width: 1.5)),
      child: Container(
        decoration:
            BoxDecoration(color: animation.value, shape: BoxShape.circle),
      ),
    );
  }
}
