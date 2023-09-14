import 'package:flutter_contacts/contact.dart';
import 'package:planner/domain/entity/reminder/reminder_types.dart';

class Reminder {
  Reminder(
      {required this.id,
      required this.folderId,
      required this.type,
      required this.time,
      required this.title,
      this.contacts,
      this.action});

  final String id;
  final ReminderType type;
  final String title;
  final DateTime time;
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
      String? action}) {
    return Reminder(
      id: id ?? this.id,
      title: title ?? this.title,
      time: time ?? this.time,
      contacts: contacts ?? this.contacts,
      action: action ?? this.action,
      type: type ?? this.type,
      folderId: folderId ?? this.folderId,
    );
  }
}
