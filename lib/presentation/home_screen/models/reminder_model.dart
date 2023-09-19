import 'package:flutter/cupertino.dart';
import 'package:planner/data/repository/reminder_repository.dart';
import 'package:planner/domain/entity/reminder/reminder.dart';

class ReminderListModel extends ChangeNotifier {
  ReminderListModel(this.repository);

  final ReminderRepository repository;
  late List<Reminder> reminders;

  Future<void> onScreenLoad() async {
    reminders = await repository.getItems();
    notifyListeners();
  }

  Future<void> onAddReminderClick(Reminder reminder) async {
    await repository.createItem(reminder);
    reminders.add(reminder);
    notifyListeners();
  }

  Future<void> onDeleteReminderClick(Reminder reminder) async {
    await repository.deleteItem(reminder);
    reminders.remove(reminder);
    notifyListeners();
  }
}
