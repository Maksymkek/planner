import 'package:hive/hive.dart';
import 'package:planner/data/adapters/adapters_typeid.dart';
import 'package:planner/data/data_model/data_model.dart';
import 'package:planner/domain/entity/reminder/reminder_replay.dart';

part 'reminder_data_model.g.dart';

@HiveType(typeId: AdaptersTypeId.reminder)
class ReminderDataModel implements DataModel {
  ReminderDataModel(
      {required this.id,
      required this.title,
      required this.description,
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
  final String title;
  @HiveField(2)
  final DateTime time;
  @HiveField(3)
  final String folderId;
  @HiveField(4)
  final List<String>? contacts;
  @HiveField(5)
  final String? action;
  @HiveField(6)
  final ReminderRepeat? repeat;
  @HiveField(7, defaultValue: 1)
  final int startDay;
  @HiveField(8)
  final String description;
}
