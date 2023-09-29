import 'package:flutter/cupertino.dart';
import 'package:planner/app_colors.dart';
import 'package:planner/data/repository/repository.dart';
import 'package:planner/dependencies/di_container.dart';
import 'package:planner/domain/entity/folder/folder.dart';
import 'package:planner/extensions/folder_list_extension.dart';
import 'package:planner/presentation/common_widgets/app_button.dart';
import 'package:planner/presentation/folder_form/folder_form.dart';
import 'package:planner/presentation/home_screen/main_content_widget.dart';
import 'package:planner/presentation/home_screen/models/folder_list_model.dart';
import 'package:planner/presentation/home_screen/models/reminder_list_model.dart';
import 'package:planner/presentation/router.dart';
import 'package:provider/provider.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late final ReminderListModel reminderListModel;
  late final FolderListModel folderListModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0, left: 20.0, top: 5.0),
      child: MultiProvider(
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
        child: Stack(
          children: [
            ListView(
              physics: const BouncingScrollPhysics(),
              controller: ScrollController(initialScrollOffset: 0.1),
              children: [
                MainContentWidget(key: MainContentWidget.globalKey),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Builder(builder: (context) {
                  return Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      AppButtonWidget(
                          text: 'Reminder',
                          icon: CupertinoIcons.plus_circle_fill,
                          iconSize: 26,
                          onPressed: () {
                            onQuickReminderPressed(context);
                          },
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
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onQuickReminderPressed(BuildContext context) async {
    final folderListModel =
        Provider.of<FolderListModel>(context, listen: false);
    Folder? quickRemindersFolder =
        folderListModel.folders.getById('quick_reminders');
    if (quickRemindersFolder == null) {
      quickRemindersFolder = Folder(
          id: 'quick_reminders',
          title: 'Quick reminders',
          background: AppColors.darkBlue,
          icon: CupertinoIcons.list_bullet,
          reminders: []);
      await folderListModel.onAddFolderClick(quickRemindersFolder);
    }
    Navigator.of(context)
        .pushNamed(Routes.newReminderFormPage, arguments: quickRemindersFolder)
        .whenComplete(
            () => MainContentWidget.globalKey.currentState?.screenLoadFun());
  }

  @override
  void initState() {
    super.initState();
    folderListModel =
        FolderListModel(DIContainer.injector.get<Repository<Folder>>());
    var currentDate = DateTime.now();
    reminderListModel = ReminderListModel(
        DIContainer.getReminderRepository(currentDate), currentDate);
  }
}
