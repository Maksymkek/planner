import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:planner/data/adapters/registration.dart';
import 'package:planner/presentation/router.dart';

void main() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  registerAppAdapters();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppRouter router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Flutter Planner',
      routes: router.routes,
      onGenerateRoute: router.onGenerateRoot,
      initialRoute: router.initialRoute,
    );
  }
}
