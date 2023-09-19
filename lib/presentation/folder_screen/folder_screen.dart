import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planner/app_colors.dart';
import 'package:planner/domain/entity/folder/folder.dart';
import 'package:planner/presentation/common_widgets/app_bar.dart';
import 'package:planner/presentation/folder_screen/folder_reminders_widget.dart';
import 'package:planner/presentation/folder_screen/models/folder_model.dart';
import 'package:provider/provider.dart';

class FolderScreen extends StatefulWidget {
  const FolderScreen({super.key, required this.folder});

  final Folder folder;

  @override
  State<FolderScreen> createState() => _FolderScreenState();
}

class _FolderScreenState extends State<FolderScreen> {
  late final FolderModel model;
  late final Future<void> screenLoad;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.light,
      appBar: buildAppBar(context, withLeading: true),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        controller: ScrollController(initialScrollOffset: 0.1),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  bottom: 7.0,
                  top: 5.0,
                ),
                child: Expanded(
                  child: Text(
                    widget.folder.title,
                    maxLines: 3,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        fontSize: 34, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              FutureBuilder(
                  future: screenLoad,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const CupertinoActivityIndicator();
                    }
                    return ChangeNotifierProvider(
                        create: (BuildContext context) {
                          return model;
                        },
                        child: const FolderRemindersWidget());
                  }),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    model = FolderModel(widget.folder);
    screenLoad = model.onScreenLoad();
  }
}
