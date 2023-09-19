import 'package:flutter/cupertino.dart';
import 'package:planner/app_colors.dart';
import 'package:planner/data/repository/repository.dart';
import 'package:planner/domain/entity/folder/folder.dart';

final class MockLocalFolderRepository extends Repository<Folder> {
  final List<Folder> _folders = [
    Folder(
        id: 'list',
        title: 'Quick Reminders',
        background: AppColors.darkBlue,
        icon: CupertinoIcons.list_bullet,
        unchanged: true),
    Folder(
        id: 'gift',
        title: 'Holidays',
        background: AppColors.carmineRed,
        icon: CupertinoIcons.gift_fill,
        unchanged: true),
    Folder(
        id: 'meet',
        title: 'Meetings',
        background: AppColors.lightBlue,
        icon: CupertinoIcons.person_2_fill,
        unchanged: true),
    Folder(
        id: 'lamp',
        title: 'Utilities',
        background: AppColors.yellow,
        icon: CupertinoIcons.lightbulb_fill,
        unchanged: false),
  ];

  @override
  Future<void> createItem(Folder item) async {
    _folders.add(item);
  }

  @override
  Future<void> deleteItem(Folder item) async {
    _folders.remove(item);
  }

  @override
  Future<List<Folder>> getItems() async {
    return List.from(_folders);
  }

  @override
  Future<void> updateItem(Folder item) async {
    _folders[_folders.indexOf(item)] = item;
  }
}
