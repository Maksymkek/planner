import 'package:flutter/cupertino.dart';
import 'package:planner/data/repository/repository.dart';
import 'package:planner/dependencies/di_container.dart';
import 'package:planner/domain/entity/folder/folder.dart';
import 'package:planner/domain/entity/folder/reminder_link.dart';
import 'package:planner/domain/entity/reminder/reminder.dart';
import 'package:planner/domain/entity/reminder/reminder_replay.dart';
import 'package:planner/extensions/reminder_link_list_extension.dart';

class FolderModel extends ChangeNotifier {
  FolderModel(this.folder) {
    repository = DIContainer.injector.get<Repository<Folder>>();
    final now = DateTime.now();
    date = DateTime(now.year, now.month, now.day);
  }

  late final Repository<Folder> repository;
  Folder folder;
  late DateTime date;
  final List<Reminder> reminders = [];

  Future<void> onScreenLoad() async {
    folder = await repository.getItem(folder.id) ?? folder;
    reminders.clear();
    List<ReminderLink> toRemove = [];
    for (final reminderLink in folder.reminders) {
      final reminder =
          await DIContainer.getReminderRepository(reminderLink.date)
              .getItem(reminderLink.id);
      if (reminder == null) {
        toRemove.add(reminderLink);
      } else {
        reminders.add(reminder);
      }
    }
    for (var link in toRemove) {
      folder.reminders.remove(link);
    }
    notifyListeners();
  }

  Future<void> onAddReminderClick(Reminder reminder) async {
    await DIContainer.getReminderRepository(reminder.time).createItem(reminder);
    reminders.add(reminder);
    folder.reminders.add(ReminderLink(reminder.id, reminder.time));
    await DIContainer.injector.get<Repository<Folder>>().updateItem(folder);
    notifyListeners();
  }

  Future<void> onDeleteReminderClick(Reminder reminder) async {
    await DIContainer.getReminderRepository(reminder.time)
        .deleteItem(reminder.id);
    await DIContainer.appNotification.cancelNotification(reminder.id);
    reminders.remove(reminder);
    folder.reminders.remove(folder.reminders.getLink(reminder));
    await DIContainer.injector.get<Repository<Folder>>().updateItem(folder);
    notifyListeners();
  }

  Future<void> onUpdateReminderClick(Reminder reminder) async {
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
      onScreenLoad();
    }
  }
}
