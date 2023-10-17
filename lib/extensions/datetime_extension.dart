import 'package:intl/intl.dart';
import 'package:planner/domain/entity/reminder/reminder.dart';
import 'package:planner/domain/entity/reminder/reminder_replay.dart';

extension DateTimeEx on DateTime {
  static String getDay(Reminder reminder) {
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

  static String getTime(Reminder reminder) {
    final DateFormat formatter = DateFormat.Hm();
    return formatter.format(reminder.time);
  }

  static String getRepeat(Reminder reminder) {
    if (reminder.repeat == null) {
      return '';
    }
    if (reminder.repeat != ReminderRepeat.never) {
      return 'every ${reminder.repeat?.name}';
    }
    return 'never';
  }
}
