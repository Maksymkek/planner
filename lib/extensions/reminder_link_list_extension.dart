import 'package:planner/domain/entity/folder/reminder_link.dart';
import 'package:planner/domain/entity/reminder/reminder.dart';

extension ReminderLinkList on List<ReminderLink>? {
  ReminderLink? getLink(Reminder reminder) {
    ReminderLink? searchedLink;
    this?.forEach((link) {
      if (link.id == reminder.id) {
        searchedLink = link;
        return;
      }
    });
    return searchedLink;
  }

  void updateLink(Reminder reminder) {
    this?.forEach((link) {
      if (link.id == reminder.id) {
        link.date = reminder.time;
        return;
      }
    });
  }
}
