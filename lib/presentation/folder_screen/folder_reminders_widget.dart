import 'package:flutter/material.dart';
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
}
