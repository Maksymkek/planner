import 'package:flutter/cupertino.dart';
import 'package:planner/app_colors.dart';
import 'package:planner/data/repository/reminder_repository.dart';
import 'package:planner/data/repository/repository.dart';
import 'package:planner/dependencies/di_container.dart';
import 'package:planner/domain/entity/folder/folder.dart';
import 'package:planner/presentation/common_widgets/app_button.dart';
import 'package:planner/presentation/folder_form/folder_form.dart';
import 'package:planner/presentation/home_screen/folder/folders_widget.dart';
import 'package:planner/presentation/home_screen/models/folder_model.dart';
import 'package:planner/presentation/home_screen/models/reminder_model.dart';
import 'package:planner/presentation/home_screen/reminder/reminders_widget.dart';
import 'package:provider/provider.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({
    super.key,
  });

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late final Future screenLoad;
  late final ReminderListModel reminderListModel;
  late final FolderListModel folderListModel;
  bool showForm = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    child: const Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        TodayRemindersWidget(),
                        SizedBox(height: 10.0),
                        FoldersWidget(),
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
                          onPressed: () {
                            FolderFormWidget.formKey.currentState?.show(
                                onDone: folderListModel.onAddFolderClick);
                          }),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _screenLoad() async {
    await folderListModel.onScreenLoad();
    await reminderListModel.onScreenLoad();
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
}
