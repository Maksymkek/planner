import 'package:flutter/material.dart';
import 'package:planner/domain/entity/folder/reminder_link.dart';

class Folder {
  Folder(
      {required this.id,
      required this.title,
      required this.background,
      required this.icon,
      this.unchanged = false,
      this.reminders});

  final String id;
  final String title;
  final bool unchanged;
  final Color background;
  final IconData icon;
  final List<ReminderLink>? reminders;

  Icon getIcon() => Icon(icon, size: 25, color: Colors.white);

  Folder copyWith(
      {String? id,
      String? title,
      Color? background,
      IconData? icon,
      bool? unchanged,
      List<ReminderLink>? reminders}) {
    return Folder(
      id: id ?? this.id,
      title: title ?? this.title,
      background: background ?? this.background,
      icon: icon ?? this.icon,
      unchanged: unchanged ?? this.unchanged,
      reminders: reminders ?? this.reminders,
    );
  }
}
