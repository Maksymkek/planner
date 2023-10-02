import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planner/app_colors.dart';
import 'package:planner/domain/entity/folder/folder.dart';
import 'package:planner/presentation/common_widgets/app_bar.dart';
import 'package:planner/presentation/common_widgets/app_button.dart';
import 'package:planner/presentation/folder_screen/folder_reminders_widget.dart';
import 'package:planner/presentation/folder_screen/models/folder_model.dart';
import 'package:planner/presentation/home_screen/main_content_widget.dart';
import 'package:planner/presentation/home_screen/models/reminder_list_model.dart';
import 'package:planner/presentation/router.dart';
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
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return model;
      },
      child: Builder(builder: (context) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: AppColors.light,
          appBar: buildAppBar(context, withLeading: true),
          floatingActionButton: AppButtonWidget(
              text: 'Reminder',
              icon: CupertinoIcons.plus_circle_fill,
              iconSize: 26,
              onPressed: () {
                newReminder(context);
              },
              textStyle:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              color: AppColors.buttonBlue),
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
                      top: 10.0,
                    ),
                    child: Text(
                      widget.folder.title,
                      maxLines: 3,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontSize: 34, fontWeight: FontWeight.w600),
                    ),
                  ),
                  FutureBuilder(
                      future: screenLoad,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done) {
                          return const SizedBox(
                            height: 200,
                            child: Align(
                                alignment: Alignment.center,
                                child: CupertinoActivityIndicator()),
                          );
                        }

                        return const FolderRemindersWidget();
                      }),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  void newReminder(BuildContext context) {
    Navigator.pushNamed(context, Routes.newReminderFormPage,
            arguments: widget.folder)
        .whenComplete(() {
      Provider.of<FolderModel>(context, listen: false)
          .onScreenLoad()
          .whenComplete(() {
        var homeContext = MainContentWidget.globalKey.currentContext;
        if (homeContext != null) {
          Provider.of<ReminderListModel>(homeContext, listen: false)
              .onScreenLoad();
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    model = FolderModel(widget.folder);
    screenLoad = model.onScreenLoad();
  }
}
