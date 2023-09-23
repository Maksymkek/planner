import 'package:flutter/cupertino.dart';
import 'package:planner/data/data_model/folder_data_model.dart';
import 'package:planner/domain/entity/folder/folder.dart';

abstract final class FolderMapper {
  static Folder fromDataModel(FolderDataModel model) {
    return Folder(
      id: model.id,
      title: model.title,
      background: Color(model.background),
      icon: IconData(model.icon,
          fontFamily: model.iconFamily, fontPackage: model.iconPackage),
      reminders: model.reminders,
    );
  }

  static FolderDataModel toDataModel(Folder folder) {
    return FolderDataModel(
        id: folder.id,
        title: folder.title,
        background: folder.background.value,
        icon: folder.icon.codePoint,
        iconFamily: folder.icon.fontFamily,
        iconPackage: folder.icon.fontPackage,
        reminders: folder.reminders);
  }
}
