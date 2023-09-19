import 'package:flutter/cupertino.dart';
import 'package:planner/data/repository/reminder_repository.dart';
import 'package:planner/dependencies/di_container.dart';
import 'package:planner/domain/entity/folder/folder.dart';
import 'package:planner/domain/entity/reminder/reminder.dart';

class FolderModel extends ChangeNotifier {
  FolderModel(this.folder);
  final Folder folder;
  late final List<Reminder> reminders;

  Future<void> onScreenLoad() async {
    //folder.reminders?.forEach((reminderLink) {});
    final repos = DIContainer.injector.get<ReminderRepository>();
    reminders = await repos.getItems();
    notifyListeners();
  }
}
