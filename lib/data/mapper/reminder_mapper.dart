import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:planner/data/data_model/reminder_data_model.dart';
import 'package:planner/dependencies/contacts/contacts_manager.dart';
import 'package:planner/domain/entity/reminder/reminder.dart';
import 'package:planner/extensions/contact_list_extension.dart';

abstract final class ReminderMapper {
  static Future<Reminder> fromDataModel(ReminderDataModel model) async {
    final List<Contact> reminderContacts = [];
    if (model.contacts != null) {
      final contacts = ContactManager.contacts;
      for (final String contactId in model.contacts ?? []) {
        final searched = contacts.getById(contactId);
        if (searched != null) {
          reminderContacts.add(searched);
        }
      }
    }
    return Reminder(
        id: model.id,
        folderId: model.folderId,
        time: model.time,
        title: model.title,
        description: model.description,
        repeat: model.repeat,
        contacts: reminderContacts,
        action: model.action,
        startDay: model.startDay);
  }

  static ReminderDataModel toDataModel(Reminder reminder) {
    final contacts = reminder.contacts?.map((e) => e.id).toList();
    return ReminderDataModel(
        id: reminder.id,
        title: reminder.title,
        description: reminder.description == '' ? null : reminder.description,
        time: reminder.time,
        folderId: reminder.folderId,
        repeat: reminder.repeat,
        contacts: contacts == [] ? null : contacts,
        action: reminder.action == '' ? null : reminder.action,
        startDay: reminder.startDay);
  }
}
