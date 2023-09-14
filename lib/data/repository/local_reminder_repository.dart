import 'package:planner/data/repository/reminder_repository.dart';
import 'package:planner/domain/entity/folder/reminder_link.dart';
import 'package:planner/domain/entity/reminder/reminder.dart';
import 'package:planner/domain/entity/reminder/reminder_types.dart';
import 'package:uuid/uuid.dart';

final class MockLocalReminderRepository extends ReminderRepository {
  MockLocalReminderRepository();

  final List<Reminder> _reminders = [
    Reminder(
        id: const Uuid().v1(),
        time: DateTime.now(),
        title: 'My mom\'s birthday',
        type: ReminderType.birthday,
        folderId: 'gift'),
    Reminder(
        id: const Uuid().v1(),
        time: DateTime.now(),
        title: 'Necessary meeting',
        type: ReminderType.meeting,
        folderId: 'meet'),
    Reminder(
        id: const Uuid().v1(),
        time: DateTime.now(),
        title: 'Pay for utilites',
        type: ReminderType.birthday,
        folderId: 'lamp'),
    Reminder(
        id: const Uuid().v1(),
        time: DateTime.now(),
        title: 'Father\'s birthday',
        type: ReminderType.birthday,
        folderId: 'gift'),
    Reminder(
        id: const Uuid().v1(),
        time: DateTime.now(),
        title: 'Lection meeting',
        type: ReminderType.meeting,
        folderId: 'meet'),
  ];

  @override
  Future<void> createItem(Reminder item) async {
    _reminders.add(item);
  }

  @override
  Future<void> deleteItem(Reminder item) async {
    _reminders.remove(item);
  }

  @override
  Future<List<Reminder>> getItems() async {
    return List.from(_reminders);
  }

  @override
  Future<void> updateItem(Reminder item) async {
    _reminders[_reminders.indexOf(item)] = item;
  }

  @override
  Future<Reminder?> getById(ReminderLink link) async {
    for (final reminder in _reminders) {
      if (reminder.id == link.id) {
        return reminder;
      }
    }
    return null;
  }
}
