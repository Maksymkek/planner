import 'package:hive/hive.dart';
import 'package:planner/dependencies/di_container.dart';
import 'package:planner/domain/entity/reminder/reminder_replay.dart';

/// Manages reminder boxes lifecycle
abstract final class RemindersManager {
  static const _boxName = 'reminder_boxes';

  /// need to call whenever opens reminders box to register
  /// new repository
  static Future<void> registerRepository(String name, DateTime date) async {
    date = DateTime(date.year, date.month, date.day);
    final box = await Hive.openBox<String>(_boxName);
    if (!box.containsKey(date.toString())) {
      await box.put(date.toString(), name);
    }
    await box.close();
  }

  /// need to call before app starts to delete clear all expired reminders
  static Future<void> clear() async {
    final box = await Hive.openBox<String>(_boxName);
    var now = DateTime.now();
    now = DateTime(now.year, now.month, now.day);

    final keys = box.keys.map((time) {
      return DateTime.parse(time as String);
    });
    DateTime? currentDateKey;
    final keysToClear = keys.where((repoDate) {
      if (repoDate == now) {
        currentDateKey = repoDate;
      }
      return repoDate.isBefore(now);
    });
    await box.deleteAll(keysToClear.map((e) => e.toString()));
    await _checkTodayReminders(currentDateKey);
    await box.close();
  }

  /// Checks whether is here today's expired reminders and if true deletes them
  static Future<void> _checkTodayReminders(DateTime? currentDateKey) async {
    if (currentDateKey != null) {
      final now = DateTime.now();
      final repo = DIContainer.getReminderRepository(currentDateKey);
      final remindersToCheck = await repo.getItems();
      for (final reminder in remindersToCheck) {
        if (reminder.time.isBefore(now) &&
            reminder.repeat == ReminderRepeat.never) {
          await repo.deleteItem(reminder.id);
        }
      }
    }
  }
}
