import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:planner/app_colors.dart';
import 'package:planner/domain/entity/reminder/reminder.dart';
import 'package:planner/presentation/common_widgets/slidable_widget.dart';
import 'package:planner/presentation/folder_screen/models/folder_model.dart';
import 'package:planner/presentation/home_screen/models/reminder_model.dart';
import 'package:provider/provider.dart';

class ReminderWidget extends StatelessWidget {
  const ReminderWidget(
    this.reminder, {
    super.key,
  });

  final Reminder reminder;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.35,
        motion: const DrawerMotion(),
        children: [
          SlidableActionWidget(
            onPressed: () {},
            icon: CupertinoIcons.info,
            iconSize: 26,
            color: AppColors.lightBlue,
          ),
          SlidableActionWidget(
            onPressed: () {
              Provider.of<ReminderListModel>(context)
                  .onDeleteReminderClick(reminder);
              Provider.of<FolderModel>(context).onScreenLoad();
            },
            icon: CupertinoIcons.delete,
            iconSize: 26,
            color: AppColors.carmineRed,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 4.5),
              child: PostponeButton(),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 2.5),
                  Text(
                    reminder.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    '${getDay()}, ${getTime()}',
                    maxLines: 1,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  const Divider(
                    thickness: 0.5,
                    color: Colors.grey,
                    height: 0,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String getDay() {
    final difference = DateTime.now().difference(reminder.time).inDays;
    if (difference == 0) {
      return 'Today';
    }
    if (difference == 1) {
      return 'Tomorrow';
    }
    final DateFormat formatter = DateFormat('dd.MM.yyyy');
    return formatter.format(reminder.time);
  }

  String getTime() {
    final DateFormat formatter = DateFormat.Hm();
    return formatter.format(reminder.time);
  }
}

class PostponeButton extends StatefulWidget {
  const PostponeButton({super.key});

  @override
  State<PostponeButton> createState() => _PostponeButtonState();
}

class _PostponeButtonState extends State<PostponeButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
          color: AppColors.light,
          shape: BoxShape.circle,
          border: Border.all(width: 1.5)),
    );
  }
}
