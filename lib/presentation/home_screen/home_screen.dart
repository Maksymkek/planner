import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planner/app_colors.dart';
import 'package:planner/data/repository/reminder_repository.dart';
import 'package:planner/data/repository/repository.dart';
import 'package:planner/dependencies/di_container.dart';
import 'package:planner/domain/entity/folder/folder.dart';
import 'package:planner/presentation/common_widgets/app_button.dart';
import 'package:planner/presentation/home_screen/folder/folders_widget.dart';
import 'package:planner/presentation/home_screen/models/folder_model.dart';
import 'package:planner/presentation/home_screen/models/reminder_model.dart';
import 'package:planner/presentation/home_screen/reminder/reminders_widget.dart';
import 'package:provider/provider.dart';

class HomeScreenWidget extends StatefulWidget {
  const HomeScreenWidget({super.key});

  @override
  State<HomeScreenWidget> createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  late final FolderListModel folderListModel;
  late final ReminderListModel reminderListModel;
  late final Future screenLoad;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CupertinoNavigationBar(
        backgroundColor: AppColors.light.withOpacity(0.6),
        border: null,
        trailing: Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: AppButtonWidget(
            iconSize: 30,
            icon: CupertinoIcons.ellipsis_circle,
            onPressed: () {},
          ),
        ),
      ),
      backgroundColor: AppColors.light,
      body: Padding(
        padding: const EdgeInsets.only(right: 20.0, left: 20.0, top: 5.0),
        child: FutureBuilder(
          future: screenLoad,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const SizedBox();
            }
            return Stack(
              children: [
                ListView(
                  physics: const BouncingScrollPhysics(),
                  controller: ScrollController(initialScrollOffset: 0.1),
                  children: [
                    MultiProvider(
                      providers: [
                        ChangeNotifierProvider<ReminderListModel>(
                          create: (BuildContext context) {
                            return reminderListModel;
                          },
                        ),
                        ChangeNotifierProvider<FolderListModel>(
                          create: (BuildContext context) {
                            return folderListModel;
                          },
                        ),
                      ],
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          TodayRemindersWidget(
                              reminderListModel: reminderListModel),
                          const SizedBox(height: 10.0),
                          FoldersWidget(folderListModel: folderListModel),
                        ],
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        AppButtonWidget(
                            text: 'Reminder',
                            icon: CupertinoIcons.plus_circle_fill,
                            iconSize: 26,
                            onPressed: () {},
                            textStyle: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                            color: AppColors.buttonBlue),
                        const Spacer(),
                        AppButtonWidget(
                            text: 'New list',
                            color: AppColors.buttonBlue,
                            textStyle: const TextStyle(fontSize: 18),
                            onPressed: () {}),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    folderListModel =
        FolderListModel(DIContainer.injector.get<Repository<Folder>>());
    reminderListModel =
        ReminderListModel(DIContainer.injector.get<ReminderRepository>());
    screenLoad = _screenLoad();
  }

  Future<void> _screenLoad() async {
    await folderListModel.onScreenLoad();
    await reminderListModel.onScreenLoad();
  }
}
