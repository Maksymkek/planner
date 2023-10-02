import 'package:flutter_contacts/contact.dart';
import 'package:planner/data/repository/folder_repository.dart';
import 'package:planner/dependencies/di_container.dart';
import 'package:planner/domain/entity/entity.dart';
import 'package:planner/domain/entity/reminder/reminder_replay.dart';
import 'package:planner/domain/entity/reminder/reminder_types.dart';
import 'package:planner/extensions/reminder_link_list_extension.dart';

class Reminder extends Entity {
  Reminder(
      {required super.id,
      required this.folderId,
      required this.time,
      required this.title,
      this.description = '',
      this.repeat = ReminderRepeat.never,
      this.contacts,
      required this.startDay,
      this.action});

  final String title;
  final String description;
  DateTime time;
  final int startDay;
  final ReminderRepeat? repeat;
  final String folderId;
  final List<Contact>? contacts;
  final String? action;

  Reminder copyWith(
      {String? id,
      String? folderId,
      String? title,
      ReminderType? type,
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

  Future<void> updateTimer() async {
    final folderRepo = FolderRepository();
    final folder = await folderRepo.getItem(folderId);
    var reminderRepo = DIContainer.getReminderRepository(time);
    switch (repeat) {
      case ReminderRepeat.hour:
        time = time.add(const Duration(hours: 1));
      case ReminderRepeat.day:
        time = time.add(const Duration(days: 1));
      case ReminderRepeat.month:
        time = getMonthRepeat();
      case ReminderRepeat.year:
        time = getYearRepeat();
      case ReminderRepeat.never || null:
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

  DateTime getMonthRepeat() {
    final int month;
    final int year;
    if (time.month != DateTime.december) {
      month = time.month + 1;
      year = time.year;
    } else {
      month = 1;
      year = time.year + 1;
    }
    if (startDay > 28) {
      int day = startDay;
      for (int i = 0; i < 3; i += 1) {
        final date = _updateMY(month, year, day);
        if (date != null) {
          time = date;
          break;
        }
        day -= 1;
      }
    } else {
      time = _updateMY(month, year, startDay) ?? time;
    }

    return time;
  }

  DateTime? _updateMY(int? month, int? year, int day) {
    try {
      final result = time.copyWith(
          year: year ?? time.year, month: month ?? time.month, day: day);
      if (result.month != month) {
        return null;
      }
      return result;
    } catch (_) {
      return null;
    }
  }

  DateTime getYearRepeat() {
    final int year = time.year + 1;
    if (startDay > 28) {
      int day = startDay;
      for (int i = 0; i < 3; i += 1) {
        final date = _updateMY(time.month, year, day);
        if (date != null) {
          time = date;
          break;
        }
        day -= 1;
      }
    } else {
      time = _updateMY(time.month, year, startDay) ?? time;
    }
    return time;
  }
}
