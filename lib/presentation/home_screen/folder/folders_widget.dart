import 'package:flutter/material.dart';
import 'package:planner/domain/entity/folder/folder.dart';
import 'package:planner/presentation/common_widgets/app_list.dart';
import 'package:planner/presentation/home_screen/folder/folder_tile_widget.dart';
import 'package:planner/presentation/home_screen/models/folder_list_model.dart';
import 'package:provider/provider.dart';

class FoldersWidget extends StatelessWidget {
  const FoldersWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16.0, bottom: 6.0),
          child: Text(
            'My lists',
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
          ),
        ),
        buildBody(context, Provider.of<FolderListModel>(context).folders)
      ],
    );
  }

  Widget buildBody(BuildContext context, List<Folder> folders) {
    if (folders.isEmpty) {
      return const Center(child: Text('No list found'));
    } else {
      return AppListWidget(
          children: folders
              .map<FolderTileWidget>((folder) => FolderTileWidget(
                    folder: folder,
                  ))
              .toList());
    }
  }
}
