import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:planner/data/repository/repository.dart';
import 'package:planner/dependencies/di_container.dart';
import 'package:planner/domain/entity/folder/folder.dart';
import 'package:planner/domain/entity/folder/reminder_link.dart';
import 'package:planner/domain/entity/reminder/reminder.dart';
import 'package:planner/domain/entity/reminder/reminder_replay.dart';
import 'package:planner/extensions/reminder_link_list_extension.dart';
import 'package:uuid/uuid.dart';

class ReminderFormModel extends ChangeNotifier {
  ReminderFormModel(this.reminder, this.folder);

  String? errorMessage;

  final Reminder reminder;
  final Folder folder;
  late String title;
  late String description;
  late ReminderRepeat repeat;
  late DateTime remindTime;
  late List<Contact>? contacts;
  late String action;

  void onScreenLoad() {
    title = reminder.title;
    action = reminder.action ?? '';
    description = reminder.description ?? '';
    repeat = reminder.repeat;
    final now = DateTime.now();
    contacts = reminder.contacts;
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

  void onActionChanged(String action) {
    this.action = action;
  }

  void onDatePicked(DateTime date) {
    remindTime =
        remindTime.copyWith(year: date.year, month: date.month, day: date.day);
    errorMessage = null;
    notifyListeners();
  }

  void onTimePicked(DateTime time) {
    remindTime = remindTime.copyWith(minute: time.minute, hour: time.hour);
    errorMessage = null;
    notifyListeners();
  }

  void onRepeatPicked(int repeatId) {
    repeat = ReminderRepeat.values[repeatId];
    errorMessage = null;
    notifyListeners();
  }

  void onContactsSelected(List<Contact> contacts) {
    this.contacts = contacts;
    errorMessage = null;
    notifyListeners();
  }

  Future<bool> onDoneClicked() async {
    if (remindTime.isBefore(DateTime.now())) {
      errorMessage = 'Reminder time must be in future';
      notifyListeners();
      return false;
    } else if (remindTime.day > 28 && repeat == ReminderRepeat.month) {
      errorMessage = 'Monthly repeat only supports 1-28 days';
      notifyListeners();
      return false;
    } else if (title == '') {
      errorMessage = 'Reminder title must be set';
      notifyListeners();
      return false;
    }
    final appNotificationManager = DIContainer.appNotification;
    if (await appNotificationManager.requestPermissions()) {
      final newReminder = reminder.copyWith(
          id: reminder.id == '-1' ? const Uuid().v1() : reminder.id,
          title: title,
          description: description,
          repeat: repeat,
          action: action,
          contacts: contacts,
          folderId: reminder.id == '-1' ? folder.id : reminder.folderId,
          time: remindTime);
      if (repeat != ReminderRepeat.never) {
        switch (repeat) {
          case ReminderRepeat.day:
            newReminder.time = newReminder.getHourRepeat(DateTime.now());

          case ReminderRepeat.week:
            newReminder.time = newReminder.getDayOFWeekUpdate(DateTime.now());

          case ReminderRepeat.month:
            newReminder.time = newReminder.getDayOfMonthRepeat(DateTime.now());

          case ReminderRepeat.never:
            break;
        }
      }
      if (reminder.id != '-1') {
        appNotificationManager.cancelNotification(reminder.id).whenComplete(
            () => appNotificationManager.setNotification(newReminder, folder));
        folder.reminders.updateLink(newReminder);
      } else {
        folder.reminders.add(ReminderLink(newReminder.id, newReminder.time));
        appNotificationManager.setNotification(newReminder, folder);
      }

      await DIContainer.injector.get<Repository<Folder>>().updateItem(folder);
      await DIContainer.getReminderRepository(newReminder.time)
          .updateItem(newReminder);

      return true;
    }
    return false;
  }
}
