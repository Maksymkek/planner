import 'package:hive/hive.dart';
import 'package:planner/data/adapters/adapters_typeid.dart';

part 'reminder_link.g.dart';

@HiveType(typeId: AdaptersTypeId.reminderLink)
final class ReminderLink {
  ReminderLink(this.id, this.date);

  @HiveField(0)
  final String id;
  @HiveField(1)
  DateTime date;
}
