import 'package:intl/intl.dart';
import 'package:planner/data/data_model/reminder_data_model.dart';
import 'package:planner/data/datasource/datasource.dart';
import 'package:planner/data/mapper/reminder_mapper.dart';
import 'package:planner/data/reminders_manager/reminders_manager.dart';
import 'package:planner/data/repository/repository.dart';
import 'package:planner/dependencies/contacts/contacts_manager.dart';
import 'package:planner/domain/entity/reminder/reminder.dart';

final class ReminderRepositoryImpl extends Repository<Reminder> {
  ReminderRepositoryImpl(
    this.date,
  ) {
    boxName =
        'reminders_for_${DateFormat(DateFormat.YEAR_MONTH_DAY).format(date)}';
    dataSource = DataSource(boxName);
  }

  late final String boxName;
  final DateTime date;
  late final DataSource<ReminderDataModel> dataSource;

  @override
  Future<void> createItem(Reminder item) async {
    await RemindersManager.registerRepository(boxName, date);
    await dataSource.putItem(ReminderMapper.toDataModel(item));
  }

  @override
  Future<void> deleteItem(String id) async {
    await RemindersManager.registerRepository(boxName, date);
    await dataSource.deleteItem(id);
  }

  @override
  Future<List<Reminder>> getItems() async {
    await RemindersManager.registerRepository(boxName, date);
    await ContactManager.refreshContacts();
    final List<Reminder> reminders = [];
    final reminderModels = (await dataSource.getItems());
    for (final model in reminderModels) {
      reminders.add(await ReminderMapper.fromDataModel(model));
    }
    return reminders;
  }

  @override
  Future<void> updateItem(Reminder item) async {
    await RemindersManager.registerRepository(boxName, date);
    await dataSource.putItem(ReminderMapper.toDataModel(item));
  }

  @override
  Future<Reminder?> getItem(String id) async {
    await RemindersManager.registerRepository(boxName, date);
    await ContactManager.refreshContacts();
    final model = await dataSource.getItem(id);
    if (model == null) {
      return null;
    }
    return ReminderMapper.fromDataModel(model);
  }

  Future<void> deleteAll() async {
    await RemindersManager.registerRepository(boxName, date);
    await dataSource.deleteFromDisk();
  }

  @override
  Future<void> deleteFromDisk() async {
    await RemindersManager.registerRepository(boxName, date);
    await dataSource.deleteFromDisk();
  }
}
