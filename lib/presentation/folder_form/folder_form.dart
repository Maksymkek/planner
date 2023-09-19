import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planner/app_colors.dart';
import 'package:planner/domain/entity/folder/folder.dart';
import 'package:planner/presentation/common_widgets/app_button.dart';
import 'package:planner/presentation/router.dart';
import 'package:uuid/uuid.dart';

class FolderFormWidget extends StatefulWidget {
  const FolderFormWidget({required super.key});

  static final GlobalKey<_FolderFormWidgetState> formKey = GlobalKey();

  @override
  State<FolderFormWidget> createState() => _FolderFormWidgetState();
}

class _FolderFormWidgetState extends State<FolderFormWidget>
    with SingleTickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  late final AnimationController _controller;
  late final Animation<double> _animation;
  late Future<void> Function(Folder) onDone;
  bool _offstage = true;

  void show({Folder? folder, required Future<void> Function(Folder) onDone}) {
    if (folder == null) {
      this.onDone = onDone;
      _offstage = false;
      _textController.text = folder?.title ?? '';
      _controller.forward();
      setState(() {});
    }
  }

  void _remove() {
    _controller.reverse().whenComplete(() {
      setState(() {
        _offstage = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: _offstage,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FadeTransition(
          opacity: _animation,
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              width: 220,
              decoration: const BoxDecoration(
                  color: AppColors.lightToggledGrey,
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      'New list name',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ),
                  CupertinoTextField(
                    controller: _textController,
                    maxLines: 1,
                    placeholder: 'Enter name',
                    placeholderStyle: const TextStyle(
                        fontSize: 16, color: CupertinoColors.placeholderText),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppButtonWidget(
                        onPressed: _remove,
                        text: 'Cancel',
                      ),
                      AppButtonWidget(
                        onPressed: () {
                          _remove();
                          var folder = Folder(
                              id: const Uuid().v1(),
                              title: _textController.text,
                              background: AppColors.darkBlue,
                              icon: CupertinoIcons.folder_fill);
                          onDone(folder).whenComplete(() => Navigator.pushNamed(
                              context, Routes.folderPage,
                              arguments: folder));
                        },
                        text: 'Done',
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);
  }
}
