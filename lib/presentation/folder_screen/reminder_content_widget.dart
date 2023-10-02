import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:planner/domain/entity/reminder/reminder.dart';
import 'package:planner/domain/entity/reminder/reminder_replay.dart';

class ReminderContentWidget extends StatelessWidget {
  const ReminderContentWidget({super.key, required this.reminder});

  final Reminder reminder;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 2.5),
          Text(
            reminder.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          ),
          reminder.description != ''
              ? Row(
                  children: [
                    const SizedBox(width: 1.5),
                    Expanded(
                      child: Text(
                        reminder.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                )
              : const SizedBox(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Row(
              children: [
                const SizedBox(
                  width: 2,
                ),
                Text(
                  '${getDay()}, ${getTime()}',
                  maxLines: 1,
                  style: const TextStyle(color: CupertinoColors.systemGrey),
                ),
                buildRepeatLabel(),
                const SizedBox(width: 10),
              ],
            ),
          ),
          const SizedBox(height: 3),
          const Divider(
            thickness: 0.5,
            color: Colors.grey,
            height: 0,
          ),
        ],
      ),
    );
  }

  Expanded buildRepeatLabel() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Icon(
            CupertinoIcons.repeat,
            color: CupertinoColors.systemGrey,
            size: 12,
          ),
          const SizedBox(width: 3),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 150),
            child: Text(
              getRepeat(),
              maxLines: 1,
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: CupertinoColors.systemGrey),
            ),
          ),
        ],
      ),
    );
  }

  String getDay() {
    final nowDate =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    final reminderTime =
        DateTime(reminder.time.year, reminder.time.month, reminder.time.day);
    final difference = nowDate.difference(reminderTime).inDays;
    if (difference == 0) {
      return 'Today';
    }
    if (difference == -1) {
      return 'Tomorrow';
    }
    final DateFormat formatter = DateFormat('dd.MM.yyyy');
    return formatter.format(reminder.time);
  }

  String getTime() {
    final DateFormat formatter = DateFormat.Hm();
    return formatter.format(reminder.time);
  }

  String getRepeat() {
    if (reminder.repeat == null) {
      return '';
    }
    if (reminder.repeat != ReminderRepeat.never) {
      return 'every ${reminder.repeat?.name}';
    }
    return 'never';
  }
}
