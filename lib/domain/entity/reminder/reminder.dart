import 'package:flutter_contacts/contact.dart';
import 'package:planner/data/repository/folder_repository.dart';
import 'package:planner/data/repository/repository.dart';
import 'package:planner/dependencies/di_container.dart';
import 'package:planner/domain/entity/entity.dart';
import 'package:planner/domain/entity/folder/folder.dart';
import 'package:planner/domain/entity/reminder/reminder_replay.dart';
import 'package:planner/extensions/reminder_link_list_extension.dart';

class Reminder extends Entity {
  Reminder(
      {required super.id,
      required this.folderId,
      required this.time,
      required this.title,
      this.description,
      this.repeat = ReminderRepeat.never,
      this.contacts,
      required this.startDay,
      this.action});

  final String title;
  final String? description;
  DateTime time;
  final int startDay;
  final ReminderRepeat repeat;
  final String folderId;
  final List<Contact>? contacts;
  final String? action;

  Reminder copyWith(
      {String? id,
      String? folderId,
      String? title,
      DateTime? time,
      List<Contact>? contacts,
      ReminderRepeat? repeat,
      String? description,
      String? action,
      int? startDay}) {
    return Reminder(
      id: id ?? this.id,
      title: title ?? this.title,
      time: time ?? this.time,
      contacts: contacts ?? this.contacts,
      action: action ?? this.action,
      repeat: repeat ?? this.repeat,
      folderId: folderId ?? this.folderId,
      description: description ?? this.description,
      startDay: startDay ?? this.startDay,
    );
  }

  Future<void> updateTimer(
      {Repository<Reminder>? reminderRepo, Folder? argFolder}) async {
    final folderRepo = FolderRepository();
    final folder = argFolder ?? await folderRepo.getItem(folderId);
    reminderRepo ??= DIContainer.getReminderRepository(time);
    switch (repeat) {
      case ReminderRepeat.day:
        time = getHourRepeat(DateTime.now());

      case ReminderRepeat.week:
        time = getDayOFWeekUpdate(DateTime.now());

      case ReminderRepeat.month:
        time = getDayOfMonthRepeat(DateTime.now());

      case ReminderRepeat.never:
        await reminderRepo.deleteItem(id);
        folder?.reminders.remove(folder.reminders.getLink(this));
        if (folder != null) {
          await folderRepo.updateItem(folder);
        }
        return;
    }
    await reminderRepo.deleteItem(id);
    reminderRepo = DIContainer.getReminderRepository(time);
    await reminderRepo.createItem(this);
    folder?.reminders.updateLink(this);
    if (folder != null) {
      await folderRepo.updateItem(folder);
    }
  }

  DateTime getDayOFWeekUpdate(DateTime now) {
    var result = now.copyWith(hour: time.hour, minute: time.minute, second: 0);
    if (now.weekday == time.weekday && result.isAfter(now)) {
      return result;
    }
    do {
      now = now.add(const Duration(days: 1));
    } while (now.weekday != time.weekday);
    result = now.copyWith(hour: time.hour, minute: time.minute);
    return result;
  }

  DateTime getDayOfMonthRepeat(DateTime now) {
    var result = DateTime(now.year, now.month, time.day)
        .copyWith(minute: time.minute, hour: time.hour);
    if (result.isAfter(now)) {
      return result;
    }
    result = result.copyWith(month: result.month + 1);
    return result;
  }

  DateTime getHourRepeat(DateTime now) {
    var result = now.copyWith(hour: time.hour, minute: time.minute, second: 0);
    if (result.isAfter(now)) {
      return result;
    }
    result = now
        .add(const Duration(days: 1))
        .copyWith(minute: time.minute, hour: time.hour);
    return result;
  }
}
