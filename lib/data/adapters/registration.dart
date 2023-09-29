import 'package:hive/hive.dart';
import 'package:planner/data/data_model/folder_data_model.dart';
import 'package:planner/data/data_model/reminder_data_model.dart';
import 'package:planner/domain/entity/folder/reminder_link.dart';
import 'package:planner/domain/entity/reminder/reminder_replay.dart';
import 'package:planner/domain/entity/reminder/reminder_types.dart';

void registerAppAdapters() {
  Hive.registerAdapter(FolderDataModelAdapter());
  Hive.registerAdapter(ReminderDataModelAdapter());
  Hive.registerAdapter(ReminderLinkAdapter());
  Hive.registerAdapter(ReminderRepeatAdapter());
  Hive.registerAdapter(ReminderTypeAdapter());
}
