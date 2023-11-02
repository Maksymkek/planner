import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planner/app_colors.dart';
import 'package:planner/dependencies/di_container.dart';
import 'package:planner/presentation/common_widgets/app_bar.dart';
import 'package:planner/presentation/folder_form/folder_form.dart';
import 'package:planner/presentation/home_screen/home_widget.dart';

class HomeScreenWidget extends StatefulWidget {
  const HomeScreenWidget({super.key});

  @override
  State<HomeScreenWidget> createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  late final Future init;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: false,
          appBar: buildAppBar(context),
          backgroundColor: AppColors.light,
          body: FutureBuilder(
              future: init,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const CupertinoActivityIndicator();
                }
                return const HomeWidget();
              }),
        ),
        FolderFormWidget(key: FolderFormWidget.formKey),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    init = DIContainer.init();
  }
}
