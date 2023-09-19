import 'package:flutter/cupertino.dart';
import 'package:planner/data/repository/repository.dart';
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
    await repository.deleteItem(folder);
    // folder.reminders?.forEach((element) {});
    folders.remove(folder);
    notifyListeners();
  }
}
