import 'package:hive/hive.dart';
import 'package:planner/data/adapters/adapters_typeid.dart';
import 'package:planner/data/data_model/data_model.dart';
import 'package:planner/domain/entity/reminder/reminder_replay.dart';
import 'package:planner/domain/entity/reminder/reminder_types.dart';

part 'reminder_data_model.g.dart';

@HiveType(typeId: AdaptersTypeId.reminder)
class ReminderDataModel implements DataModel {
  ReminderDataModel(
      {required this.id,
      required this.type,
      required this.title,
      required this.time,
      required this.folderId,
      required this.repeat,
      this.contacts,
      this.action,
      required this.startDay});

  @override
  @HiveField(0)
  final String id;
  @HiveField(1)
  final ReminderType type;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final DateTime time;
  @HiveField(4)
  final String folderId;
  @HiveField(5)
  final List<String>? contacts;
  @HiveField(6)
  final String? action;
  @HiveField(7)
  final ReminderRepeat? repeat;
  @HiveField(8, defaultValue: 1)
  final int startDay;
}
