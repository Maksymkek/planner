import 'package:flutter/cupertino.dart';
import 'package:planner/data/repository/repository.dart';
import 'package:planner/dependencies/di_container.dart';
import 'package:planner/domain/entity/folder/folder.dart';

class FolderListModel extends ChangeNotifier {
  FolderListModel(this.repository);

  final Repository<Folder> repository;
  late List<Folder> folders;

  Future<void> onScreenLoad() async {
    folders = await repository.getItems();
    notifyListeners();
  }

  Future<void> onAddFolderClick(Folder folder) async {
    await repository.createItem(folder);
    folders.add(folder);
    notifyListeners();
  }

  Future<void> onDeleteFolderClick(Folder folder) async {
    await repository.deleteItem(folder.id);
    folders.remove(folder);
    for (var reminderLink in folder.reminders) {
      await DIContainer.getReminderRepository(reminderLink.date)
          .deleteItem(reminderLink.id);
      await DIContainer.appNotification.cancelNotification(reminderLink.id);
    }
    notifyListeners();
  }
}
