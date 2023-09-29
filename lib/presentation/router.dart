import 'package:flutter/cupertino.dart';
import 'package:planner/domain/entity/folder/folder.dart';
import 'package:planner/domain/entity/reminder/reminder.dart';
import 'package:planner/presentation/folder_screen/folder_screen.dart';
import 'package:planner/presentation/home_screen/home_screen.dart';
import 'package:planner/presentation/reminder_form/reminder_form_widget.dart';

abstract final class Routes {
  static const homePage = 'home_page/';
  static const folderPage = 'home_page/folder_page/';
  static const editReminderFormPage = 'home_page/folder_page/reminder_form/';
  static const newReminderFormPage = 'reminder_form/';
}

class AppRouter {
  static const _initialRoute = Routes.homePage;

  String get initialRoute => _initialRoute;
  final Map<String, Widget Function(BuildContext)> routes = {
    _initialRoute: (context) {
      return const HomeScreenWidget();
    },
  };

  Route<dynamic> onGenerateRoot(RouteSettings settings) {
    switch (settings.name) {
      case Routes.folderPage:
        {
          return CupertinoPageRoute(builder: (BuildContext context) {
            return FolderScreen(folder: settings.arguments as Folder);
          });
        }
      case Routes.editReminderFormPage:
        {
          return CupertinoPageRoute(builder: (BuildContext context) {
            final arguments = settings.arguments as List<dynamic>;
            return ReminderFormWidget(
              reminder: arguments[0] as Reminder,
              folder: arguments[1] as Folder,
            );
          });
        }
      case Routes.newReminderFormPage:
        {
          return CupertinoPageRoute(builder: (BuildContext context) {
            return ReminderFormWidget(folder: settings.arguments as Folder);
          });
        }
      default:
        const defaultWidget = Text('Navigation error :(');
        return CupertinoPageRoute(builder: (context) => defaultWidget);
    }
  }
}
