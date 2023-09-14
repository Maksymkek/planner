import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:planner/data/repository/local_folder_repository.dart';
import 'package:planner/data/repository/local_reminder_repository.dart';
import 'package:planner/data/repository/reminder_repository.dart';
import 'package:planner/data/repository/repository.dart';
import 'package:planner/domain/entity/folder/folder.dart';

class DIContainer {
  static final Injector _injector = Injector();

  static Injector get injector => _injector;

  static Future<void> init() async {
    _injector
        .map<Repository<Folder>>((injector) => MockLocalFolderRepository());
    _injector
        .map<ReminderRepository>((injector) => MockLocalReminderRepository());
  }
}
