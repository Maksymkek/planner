import 'package:planner/data/data_model/reminder_data_model.dart';
import 'package:planner/domain/entity/reminder/reminder.dart';

abstract final class ReminderMapper {
  static Reminder fromDataModel(ReminderDataModel model) {
    return Reminder(
        id: model.id,
        folderId: model.folderId,
        time: model.time,
        title: model.title,
        description: model.description,
        repeat: model.repeat,
        contacts: null,
        action: model.action,
        startDay: model.startDay);
  }

  static ReminderDataModel toDataModel(Reminder reminder) {
    return ReminderDataModel(
        id: reminder.id,
        title: reminder.title,
        description: reminder.description,
        time: reminder.time,
        folderId: reminder.folderId,
        repeat: reminder.repeat,
        contacts: reminder.contacts?.map((e) => e.id).toList(),
        action: reminder.action,
        startDay: reminder.startDay);
  }
}
