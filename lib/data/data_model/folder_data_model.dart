import 'package:hive/hive.dart';
import 'package:planner/data/adapters/adapters_typeid.dart';
import 'package:planner/data/data_model/data_model.dart';
import 'package:planner/domain/entity/folder/reminder_link.dart';

part 'folder_data_model.g.dart';

@HiveType(typeId: AdaptersTypeId.folder)
class FolderDataModel implements DataModel {
  const FolderDataModel({
    required this.id,
    required this.title,
    required this.background,
    required this.icon,
    required this.reminders,
    this.iconPackage,
    this.iconFamily,
  });

  @override
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final int background;
  @HiveField(3)
  final int icon;
  @HiveField(4)
  final String? iconPackage;
  @HiveField(5)
  final String? iconFamily;
  @HiveField(6)
  final List<ReminderLink> reminders;
}
