import 'dart:async';

import 'package:flutter/material.dart';
import 'package:planner/domain/timer.dart';
import 'package:planner/presentation/folder_screen/models/folder_model.dart';
import 'package:planner/presentation/folder_screen/reminder_widget.dart';
import 'package:provider/provider.dart';

class FolderRemindersWidget extends StatefulWidget {
  const FolderRemindersWidget({super.key});

  @override
  State<FolderRemindersWidget> createState() => _FolderRemindersWidgetState();
}

class _FolderRemindersWidgetState extends State<FolderRemindersWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: Provider.of<FolderModel>(context)
          .reminders
          .map((reminder) => ReminderWidget(reminder))
          .toList(),
    );
  }

  @override
  void initState() {
    super.initState();
    AppTimer.instance().addListener(_checkUpdate);
  }

  @override
  void dispose() {
    AppTimer.instance().removeListener(_checkUpdate);
    super.dispose();
  }

  Future<void> _checkUpdate(Timer timer) async {
    bool needToUpdate = false;
    final now = DateTime.now();
    await Provider.of<FolderModel>(context, listen: false).checkDateUpdate(now);
    Provider.of<FolderModel>(context, listen: false)
        .reminders
        .forEach((reminder) async {
      if (reminder.time.isBefore(now)) {
        needToUpdate = true;
        return;
      }
    });
    if (needToUpdate) {
      needToUpdate = false;
      await Provider.of<FolderModel>(context, listen: false).onScreenLoad();
    }
  }
}
