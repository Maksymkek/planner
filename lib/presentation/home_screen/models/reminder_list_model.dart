import 'package:flutter/cupertino.dart';
import 'package:planner/data/repository/reminder_repository_impl.dart';
import 'package:planner/data/repository/repository.dart';
import 'package:planner/dependencies/di_container.dart';
import 'package:planner/domain/entity/reminder/reminder.dart';
import 'package:planner/domain/entity/reminder/reminder_replay.dart';

class ReminderListModel extends ChangeNotifier {
  ReminderListModel(this.repository, DateTime date) {
    this.date = DateTime(date.year, date.month, date.day);
  }

  Repository<Reminder> repository;
  late DateTime date;
  late List<Reminder> reminders;

  Future<void> onScreenLoad() async {
    reminders = await repository.getItems()
      ..sort((a, b) => a.time.compareTo(b.time));
    notifyListeners();
  }

  Future<void> onUpdateReminderTime(Reminder reminder) async {
    if (reminder.repeat == ReminderRepeat.never) {
      await reminder.updateTimer();
      await onScreenLoad();
      await DIContainer.appNotification.cancelNotification(reminder.id);
    }
  }

  Future<void> checkDateUpdate(DateTime? nowTime) async {
    final now = nowTime ?? DateTime.now();
    final currentDate = DateTime(now.year, now.month, now.day);
    if (date.isBefore(currentDate)) {
      date = currentDate;
      repository = ReminderRepositoryImpl(date);
      onScreenLoad();
    }
  }
}
