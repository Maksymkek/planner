import 'package:hive/hive.dart';
import 'package:planner/data/adapters/adapters_typeid.dart';

part 'reminder_replay.g.dart';

@HiveType(typeId: AdaptersTypeId.reminderRepeat)
enum ReminderRepeat {
  @HiveField(0)
  hour,
  @HiveField(1)
  day,
  @HiveField(2)
  month,
  @HiveField(3)
  year,
  @HiveField(4)
  never,
}
