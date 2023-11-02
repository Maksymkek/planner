import 'package:planner/data/data_model/folder_data_model.dart';
import 'package:planner/data/datasource/datasource.dart';
import 'package:planner/data/mapper/folder_mapper.dart';
import 'package:planner/data/repository/repository.dart';
import 'package:planner/domain/entity/folder/folder.dart';

final class FolderRepository extends Repository<Folder> {
  final DataSource<FolderDataModel> dataSource = DataSource('folder_box');

  @override
  Future<void> createItem(Folder item) async {
    await dataSource.putItem(FolderMapper.toDataModel(item));
  }

  @override
  Future<void> deleteItem(String id) async {
    await dataSource.deleteItem(id);
  }

  @override
  Future<List<Folder>> getItems() async {
    return (await dataSource.getItems())
        .map((dataModel) => FolderMapper.fromDataModel(dataModel))
        .toList();
  }

  @override
  Future<void> updateItem(Folder item) async {
    await dataSource.putItem(FolderMapper.toDataModel(item));
  }

  @override
  Future<Folder?> getItem(String id) async {
    final model = await dataSource.getItem(id);
    if (model == null) {
      return null;
    }
    return FolderMapper.fromDataModel(model);
  }

  @override
  Future<void> deleteFromDisk() async {
    await dataSource.deleteFromDisk();
  }
}
