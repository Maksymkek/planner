import 'package:hive/hive.dart';
import 'package:planner/data/adapters/adapters_typeid.dart';

part 'reminder_replay.g.dart';

@HiveType(typeId: AdaptersTypeId.reminderRepeat)
enum ReminderRepeat {
  @HiveField(0)
  day,
  @HiveField(1)
  week,
  @HiveField(2)
  month,
  @HiveField(3)
  never,
}
