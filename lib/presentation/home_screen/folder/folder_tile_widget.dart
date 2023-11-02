import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:planner/app_colors.dart';
import 'package:planner/domain/entity/folder/folder.dart';
import 'package:planner/presentation/common_widgets/slidable_widget.dart';
import 'package:planner/presentation/common_widgets/tile_widget.dart';
import 'package:planner/presentation/home_screen/models/folder_list_model.dart';
import 'package:planner/presentation/home_screen/models/reminder_list_model.dart';
import 'package:planner/presentation/router.dart';
import 'package:provider/provider.dart';

class FolderTileWidget extends StatelessWidget {
  const FolderTileWidget({super.key, required this.folder});

  final Folder folder;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.2,
        motion: const DrawerMotion(),
        children: [
          SlidableActionWidget(
              icon: CupertinoIcons.delete_solid,
              color: AppColors.carmineRed,
              onPressed: () {
                Provider.of<FolderListModel>(context, listen: false)
                    .onDeleteFolderClick(folder);
              })
        ],
      ),
      child: TileWidget(
        withDivider:
            Provider.of<FolderListModel>(context, listen: false).folders.last !=
                folder,
        title: folder.title,
        background: folder.background,
        trailing: const Icon(
          CupertinoIcons.chevron_right,
          color: CupertinoColors.black,
          size: 18,
        ),
        icon: folder.getIcon(),
        onPressed: () {
          Navigator.of(context)
              .pushNamed(Routes.folderPage, arguments: folder)
              .whenComplete(() {
            Provider.of<ReminderListModel>(context, listen: false)
                .onScreenLoad();
          });
        },
      ),
    );
  }
}
