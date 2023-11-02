import 'package:hive_flutter/hive_flutter.dart';
import 'package:planner/data/data_model/data_model.dart';

class DataSource<ItemDataModel extends DataModel> {
  DataSource(this._boxName);

  late Box<ItemDataModel> box;
  final String _boxName;

  Future<List<ItemDataModel>> getItems() async {
    box = await Hive.openBox(_boxName);
    final items = box.values.toList();
    await box.close();
    return items;
  }

  Future<ItemDataModel?> getItem(String id) async {
    box = await Hive.openBox(_boxName);
    final item = box.get(id);
    await box.close();
    return item;
  }

  Future<void> putItem(ItemDataModel item) async {
    box = await Hive.openBox(_boxName);
    await box.put(item.id, item);
    await box.close();
  }

  Future<void> deleteItem(String id) async {
    box = await Hive.openBox(_boxName);
    await box.delete(id);
    if (box.values.isEmpty) {
      await box.deleteFromDisk();
      return;
    }
    await box.close();
  }

  Future<void> deleteFromDisk() async {
    box = await Hive.openBox(_boxName);
    await box.deleteFromDisk();
    await box.close();
  }
}
