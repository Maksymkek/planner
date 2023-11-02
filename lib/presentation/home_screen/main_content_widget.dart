import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:planner/domain/entity/reminder/reminder.dart';
import 'package:planner/domain/timer.dart';
import 'package:planner/presentation/home_screen/folder/folders_widget.dart';
import 'package:planner/presentation/home_screen/models/folder_list_model.dart';
import 'package:planner/presentation/home_screen/models/reminder_list_model.dart';
import 'package:planner/presentation/home_screen/reminder/reminders_widget.dart';
import 'package:provider/provider.dart';

class MainContentWidget extends StatefulWidget {
  const MainContentWidget({
    required super.key,
  });

  static final GlobalKey<_MainContentWidgetState> globalKey = GlobalKey();

  @override
  State<MainContentWidget> createState() => _MainContentWidgetState();
}

class _MainContentWidgetState extends State<MainContentWidget> {
  late final Future<void> onScreenLoad;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: onScreenLoad,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const SizedBox();
          }
          return Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              TodayRemindersWidget(key: TodayRemindersWidget.todayRemindersKey),
              const SizedBox(height: 10.0),
              const FoldersWidget(),
            ],
          );
        });
  }

  Future<void> screenLoadFun() async {
    await Provider.of<FolderListModel>(context, listen: false).onScreenLoad();
    await Provider.of<ReminderListModel>(context, listen: false).onScreenLoad();
  }

  @override
  void initState() {
    super.initState();
    onScreenLoad = screenLoadFun().whenComplete(() {
      AppTimer.instance().addListener(_checkUpdate);
    });
  }

  @override
  void dispose() {
    AppTimer.instance().removeListener(_checkUpdate);
    super.dispose();
  }

  Future<void> _checkUpdate(Timer timer) async {
    bool needToUpdate = false;
    Reminder? reminderToUpdate;
    final now = DateTime.now();
    await Provider.of<ReminderListModel>(context, listen: false)
        .checkDateUpdate(now);
    Provider.of<ReminderListModel>(context, listen: false)
        .reminders
        .forEach((reminder) async {
      if (reminder.time.isBefore(now)) {
        reminderToUpdate = reminder;
        needToUpdate = true;
        return;
      }
    });
    if (needToUpdate) {
      needToUpdate = false;
      await reminderToUpdate?.updateTimer();
      await Provider.of<FolderListModel>(context, listen: false).onScreenLoad();
      await Provider.of<ReminderListModel>(context, listen: false)
          .onScreenLoad();
    }
  }
}
