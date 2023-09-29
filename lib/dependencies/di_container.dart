import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:planner/data/reminders_manager/reminders_manager.dart';
import 'package:planner/data/repository/folder_repository.dart';
import 'package:planner/data/repository/reminder_repository_impl.dart';
import 'package:planner/data/repository/repository.dart';
import 'package:planner/dependencies/notifications/app_notifications.dart';
import 'package:planner/domain/entity/folder/folder.dart';
import 'package:planner/domain/entity/reminder/reminder.dart';

class DIContainer {
  static final Injector _injector = Injector();

  static Injector get injector => _injector;
  static late final AppNotification appNotification;

  static Future<void> init() async {
    _injector.map<Repository<Folder>>((injector) => FolderRepository());
    appNotification = AppNotification();
    await appNotification.init();
    await RemindersManager.clear();
  }

  static Repository<Reminder> getReminderRepository(DateTime date) {
    return ReminderRepositoryImpl(date);
  }
}
