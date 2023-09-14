import 'package:flutter/material.dart';
import 'package:planner/dependencies/di_container.dart';

import 'presentation/home_screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final Future init;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder(
        future: init,
        builder: (context, result) {
          if (result.connectionState == ConnectionState.done) {
            return const HomeScreenWidget();
          }
          return const SizedBox();
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    init = DIContainer.init();
  }
}
