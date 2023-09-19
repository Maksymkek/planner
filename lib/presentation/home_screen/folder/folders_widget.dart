import 'package:flutter/material.dart';
import 'package:planner/presentation/common_widgets/app_list.dart';
import 'package:planner/presentation/home_screen/folder/folder_tile_widget.dart';
import 'package:planner/presentation/home_screen/models/folder_model.dart';
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
          padding: EdgeInsets.only(left: 16.0, bottom: 5.0),
          child: Text(
            'My lists',
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
        ),
        AppListWidget(
            children: Provider.of<FolderListModel>(context)
                .folders
                .map<FolderTileWidget>((e) => FolderTileWidget(
                      folder: e,
                    ))
                .toList()),
      ],
    );
  }
}
