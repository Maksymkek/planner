import 'package:flutter/cupertino.dart';
import 'package:planner/data/repository/repository.dart';
import 'package:planner/dependencies/di_container.dart';
import 'package:planner/domain/entity/folder/folder.dart';
import 'package:planner/domain/entity/folder/reminder_link.dart';
import 'package:planner/domain/entity/reminder/reminder.dart';
import 'package:planner/domain/entity/reminder/reminder_replay.dart';
import 'package:uuid/uuid.dart';

class ReminderFormModel extends ChangeNotifier {
  ReminderFormModel(this.reminder, this.folder);

  final Reminder reminder;
  final Folder folder;
  late String title;
  late String description;
  late ReminderRepeat repeat;
  late DateTime remindTime;

  void onScreenLoad() {
    title = reminder.title;
    description = reminder.description;
    repeat = reminder.repeat ?? ReminderRepeat.never;
    final now = DateTime.now();
    remindTime = reminder.id != '-1'
        ? reminder.time
        : DateTime(now.year, now.month, now.day, now.hour, now.minute);
    notifyListeners();
  }

  void onTitleChanged(String title) {
    this.title = title;
  }

  void onDescriptionChanged(String description) {
    this.description = description;
  }

  void onDatePicked(DateTime date) {
    remindTime =
        remindTime.copyWith(year: date.year, month: date.month, day: date.day);
    notifyListeners();
  }

  void onTimePicked(DateTime time) {
    remindTime = remindTime.copyWith(minute: time.minute, hour: time.hour);
    notifyListeners();
  }

  void onRepeatPicked(int repeatId) {
    repeat = ReminderRepeat.values[repeatId];
    notifyListeners();
  }

  Future<bool> onDoneClicked() async {
    final appNotificationManager = DIContainer.appNotification;
    if (await appNotificationManager.requestPermissions() &&
        remindTime.isAfter(DateTime.now())) {
      final newReminder = reminder.copyWith(
          id: reminder.id == '-1' ? const Uuid().v1() : reminder.id,
          title: title,
          description: description,
          repeat: repeat,
          folderId: reminder.id == '-1' ? folder.id : reminder.folderId,
          time: remindTime);
      folder.reminders.add(ReminderLink(newReminder.id, newReminder.time));
      await DIContainer.injector.get<Repository<Folder>>().updateItem(folder);
      await DIContainer.getReminderRepository(newReminder.time)
          .updateItem(newReminder);
      appNotificationManager.setNotification(newReminder, folder);
      return true;
    }
    return false;
  }
}
