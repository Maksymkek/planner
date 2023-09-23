import 'package:hive/hive.dart';
import 'package:planner/data/adapters/adapters_typeid.dart';

part 'reminder_types.g.dart';

@HiveType(typeId: AdaptersTypeId.reminderType)
enum ReminderType {
  @HiveField(0)
  birthday,
  @HiveField(1)
  meeting,
  @HiveField(2)
  other,
}
