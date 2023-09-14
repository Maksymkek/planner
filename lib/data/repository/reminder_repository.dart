import 'package:planner/data/repository/repository.dart';
import 'package:planner/domain/entity/folder/reminder_link.dart';
import 'package:planner/domain/entity/reminder/reminder.dart';

abstract base class ReminderRepository extends Repository<Reminder> {
  Future<Reminder?> getById(ReminderLink link);
}
