import 'package:flutter/cupertino.dart';
import 'package:planner/presentation/router.dart';

void main() {
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
