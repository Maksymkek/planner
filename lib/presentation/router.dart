import 'package:flutter/cupertino.dart';
import 'package:planner/domain/entity/folder/folder.dart';
import 'package:planner/presentation/folder_screen/folder_screen.dart';
import 'package:planner/presentation/home_screen/home_screen.dart';

abstract final class Routes {
  static const homePage = 'home_page/';
  static const folderPage = 'home_page/folder_page/';
}

class AppRouter {
  static const _initialRoute = Routes.homePage;

  String get initialRoute => _initialRoute;
  final Map<String, Widget Function(BuildContext)> routes = {
    _initialRoute: (context) {
      return const HomeScreenWidget();
    }
  };

  Route<dynamic> onGenerateRoot(RouteSettings settings) {
    switch (settings.name) {
      case Routes.folderPage:
        {
          return CupertinoPageRoute(builder: (BuildContext context) {
            return FolderScreen(folder: settings.arguments as Folder);
          });
        }
      default:
        const defaultWidget = Text('Navigation error :(');
        return CupertinoPageRoute(builder: (context) => defaultWidget);
    }
  }
}
