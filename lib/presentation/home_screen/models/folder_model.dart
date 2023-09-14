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
}
