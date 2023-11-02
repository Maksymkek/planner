import 'package:planner/domain/entity/reminder/reminder.dart';
import 'package:test/test.dart';

void main() {
  group('Timer update test after notify', () {
    test('month update test', () {
      final reminder = Reminder(
          id: '1',
          folderId: '1',
          time: DateTime(2025, 12, 28),
          title: 'test',
          startDay: 21);
      final result = reminder
          .getDayOfMonthRepeat(reminder.time.add(const Duration(hours: 1)));
      expect(result, DateTime(2026, 01, 28));
    });
    test('time update test', () {
      final reminder = Reminder(
          id: '1',
          folderId: '1',
          time: DateTime(2023, 10, 28, 10, 30),
          title: 'test',
          startDay: 21);
      final result = reminder
          .getHourRepeat(reminder.time.subtract(const Duration(hours: 1)));
      expect(result, DateTime(2023, 10, 28, 10, 30));
    });
    test('day of week update test', () {
      final reminder = Reminder(
          id: '1',
          folderId: '1',
          time: DateTime(2023, 10, 13, 10, 00),
          title: 'test',
          startDay: 21);
      final result = reminder.getDayOFWeekUpdate(
          reminder.time.subtract(const Duration(minutes: 1)));
      expect(result, DateTime(2023, 10, 13, 10, 00));
    });
  });
}
