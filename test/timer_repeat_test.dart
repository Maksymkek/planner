import 'package:planner/domain/entity/reminder/reminder.dart';
import 'package:planner/domain/entity/reminder/reminder_types.dart';
import 'package:test/test.dart';

void main() {
  group('Timer update test after notify', () {
    test('year update test', () {
      final reminder = Reminder(
          id: '1',
          folderId: '1',
          type: ReminderType.other,
          time: DateTime(2027, 2, 28, 18),
          title: 'test',
          startDay: 29);
      final result = reminder.getYearRepeat();
      expect(result, DateTime(2028, 2, 29, 18));
    });
    test('month update test', () {
      final reminder = Reminder(
          id: '1',
          folderId: '1',
          type: ReminderType.other,
          time: DateTime(2023, 12, 21),
          title: 'test',
          startDay: 21);
      final result = reminder.getMonthRepeat();
      expect(result, DateTime(2024, 01, 21));
    });
  });
}
