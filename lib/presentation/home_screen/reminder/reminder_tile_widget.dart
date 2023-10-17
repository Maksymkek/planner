import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:planner/app_colors.dart';
import 'package:planner/domain/entity/reminder/reminder.dart';
import 'package:planner/extensions/folder_list_extension.dart';
import 'package:planner/presentation/common_widgets/slidable_widget.dart';
import 'package:planner/presentation/common_widgets/tile_widget.dart';
import 'package:planner/presentation/home_screen/models/folder_list_model.dart';
import 'package:planner/presentation/home_screen/models/reminder_list_model.dart';
import 'package:planner/presentation/router.dart';
import 'package:provider/provider.dart';

class ReminderTileWidget extends StatelessWidget {
  const ReminderTileWidget({super.key, required this.reminder});

  final Reminder reminder;

  @override
  Widget build(BuildContext context) {
    var folder = Provider.of<FolderListModel>(context, listen: false)
        .folders
        .getById(reminder.folderId);
    return Slidable(
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          extentRatio: 0.2,
          children: [
            SlidableActionWidget(
                onPressed: () {
                  Provider.of<ReminderListModel>(context, listen: false)
                      .onUpdateReminderTime(reminder);
                },
                icon: CupertinoIcons.checkmark,
                color: AppColors.yellow),
          ],
        ),
        child: TileWidget(
          icon: folder?.getIcon() ?? const Icon(CupertinoIcons.folder_fill),
          background: folder?.background ?? CupertinoColors.darkBackgroundGray,
          title: reminder.title,
          trailing: buildTimer(),
          withDivider: Provider.of<ReminderListModel>(context, listen: false)
                  .reminders
                  .last !=
              reminder,
          onPressed: () {
            Navigator.pushNamed(context, Routes.folderPage, arguments: folder)
                .whenComplete(
                    Provider.of<ReminderListModel>(context, listen: false)
                        .onScreenLoad);
          },
        ));
  }

  Container buildTimer() {
    final DateFormat formatter = DateFormat.Hm();
    final String formatted = formatter.format(reminder.time);
    return Container(
      decoration: BoxDecoration(
          color: AppColors.light, borderRadius: BorderRadius.circular(8.0)),
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
      child: Row(
        children: [
          const Icon(
            CupertinoIcons.timer,
            color: CupertinoColors.black,
            size: 14,
          ),
          const SizedBox(width: 3),
          Text(
            formatted,
            style: const TextStyle(fontSize: 14),
          )
        ],
      ),
    );
  }
}
