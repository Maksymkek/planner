import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:planner/app_colors.dart';
import 'package:planner/domain/entity/folder/folder.dart';
import 'package:planner/presentation/common_widgets/slidable_widget.dart';
import 'package:planner/presentation/common_widgets/tile_widget.dart';
import 'package:planner/presentation/home_screen/models/folder_model.dart';
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
              icon: CupertinoIcons.delete,
              color: AppColors.carmineRed,
              onPressed: () {})
        ],
      ),
      child: TileWidget(
        withDivider:
            Provider.of<FolderListModel>(context).folders.last != folder,
        title: folder.title,
        background: folder.background,
        trailing: const Icon(
          CupertinoIcons.chevron_right,
          size: 18,
        ),
        icon: folder.icon,
        onPressed: () {},
      ),
    );
  }
}
