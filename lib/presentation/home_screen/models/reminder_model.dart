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
}
