import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planner/presentation/common_widgets/app_list.dart';
import 'package:planner/presentation/home_screen/models/reminder_model.dart';
import 'package:planner/presentation/home_screen/reminder/reminder_tile_widget.dart';

class TodayRemindersWidget extends StatelessWidget {
  const TodayRemindersWidget({
    super.key,
    required this.reminderListModel,
  });

  final ReminderListModel reminderListModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 14.0, bottom: 5.0),
          child: Text(
            'Today',
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 34, fontWeight: FontWeight.w600),
          ),
        ),
        AppListWidget(
            children: reminderListModel.reminders
                .map<ReminderTileWidget>((e) => ReminderTileWidget(
                      reminder: e,
                    ))
                .toList()),
      ],
    );
  }
}
