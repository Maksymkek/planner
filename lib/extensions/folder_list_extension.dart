import 'package:planner/domain/entity/folder/folder.dart';

extension FolderListExtension on List<Folder> {
  Folder? getById(String id) {
    for (final element in this) {
      if (element.id == id) {
        return element;
      }
    }
    return null;
  }
}
