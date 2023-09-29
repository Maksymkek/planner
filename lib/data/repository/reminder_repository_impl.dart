import 'package:intl/intl.dart';
import 'package:planner/data/data_model/reminder_data_model.dart';
import 'package:planner/data/datasource/datasource.dart';
import 'package:planner/data/mapper/reminder_mapper.dart';
import 'package:planner/data/reminders_manager/reminders_manager.dart';
import 'package:planner/data/repository/repository.dart';
import 'package:planner/domain/entity/reminder/reminder.dart';

final class ReminderRepositoryImpl extends Repository<Reminder> {
  ReminderRepositoryImpl(
    DateTime date,
  ) {
    final boxName =
        'reminders_for_${DateFormat(DateFormat.YEAR_MONTH_DAY).format(date)}';
    dataSource = DataSource(boxName);
    RemindersManager.registerRepository(boxName, date);
  }

  late final DataSource<ReminderDataModel> dataSource;

  @override
  Future<void> createItem(Reminder item) async {
    await dataSource.putItem(ReminderMapper.toDataModel(item));
  }

  @override
  Future<void> deleteItem(String id) async {
    await dataSource.deleteItem(id);
  }

  @override
  Future<List<Reminder>> getItems() async {
    return (await dataSource.getItems())
        .map((dataModel) => ReminderMapper.fromDataModel(dataModel))
        .toList();
  }

  @override
  Future<void> updateItem(Reminder item) async {
    await dataSource.putItem(ReminderMapper.toDataModel(item));
  }

  @override
  Future<Reminder?> getItem(String id) async {
    final model = await dataSource.getItem(id);
    if (model == null) {
      return null;
    }
    return ReminderMapper.fromDataModel(model);
  }

  Future<void> deleteAll() async {
    await dataSource.deleteFromDisk();
  }

  @override
  Future<void> close() async {
    await dataSource.closeBox();
  }
}
