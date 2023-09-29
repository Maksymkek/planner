import 'package:flutter/cupertino.dart';
import 'package:planner/data/repository/reminder_repository_impl.dart';
import 'package:planner/data/repository/repository.dart';
import 'package:planner/domain/entity/reminder/reminder.dart';

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

  Future<void> onDeleteReminder(Reminder reminder) async {
    await repository.deleteItem(reminder.id);
    notifyListeners();
  }

  Future<void> checkDateUpdate(DateTime? nowTime) async {
    final now = nowTime ?? DateTime.now();
    if (now.hour == 0) {
      final currentDate = DateTime(now.year, now.month, now.day);
      if (date.isBefore(currentDate)) {
        date = currentDate;
        repository = ReminderRepositoryImpl(date);
        onScreenLoad();
      }
    }
  }
}
