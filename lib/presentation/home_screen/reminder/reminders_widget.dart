import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planner/presentation/common_widgets/app_list.dart';
import 'package:planner/presentation/home_screen/models/reminder_list_model.dart';
import 'package:planner/presentation/home_screen/reminder/reminder_tile_widget.dart';
import 'package:provider/provider.dart';

class TodayRemindersWidget extends StatefulWidget {
  const TodayRemindersWidget({
    super.key,
  });

  static final GlobalKey<_TodayRemindersWidgetState> todayRemindersKey =
      GlobalKey();

  @override
  State<TodayRemindersWidget> createState() => _TodayRemindersWidgetState();
}

class _TodayRemindersWidgetState extends State<TodayRemindersWidget> {
  @override
  Widget build(BuildContext context) {
    final todayReminders = Provider.of<ReminderListModel>(context).reminders;
    if (todayReminders.isEmpty) {
      return const SizedBox();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 14.0, bottom: 8.0),
          child: Text(
            'Today',
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 34, fontWeight: FontWeight.w600),
          ),
        ),
        AppListWidget(
            children: Provider.of<ReminderListModel>(context)
                .reminders
                .map<ReminderTileWidget>((reminder) => ReminderTileWidget(
                      reminder: reminder,
                    ))
                .toList()),
      ],
    );
  }
}
