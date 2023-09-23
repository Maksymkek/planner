import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planner/domain/entity/folder/folder.dart';
import 'package:planner/presentation/folder_form/folder_form_model.dart';
import 'package:planner/presentation/folder_form/icon_picker/folder_form_buttons.dart';
import 'package:planner/presentation/folder_form/icon_picker/icon_picker_list.dart';
import 'package:provider/provider.dart';

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
  FolderFormModel? _model = FolderFormModel();

//TODO for edit folder
  void show({Folder? folder, required Future<void> Function(Folder) onDone}) {
    if (folder == null) {
      this.onDone = onDone;
      _offstage = false;
      _textController.text = '';
      _model = FolderFormModel();
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
      child: ChangeNotifierProvider(
        create: (context) {
          return _model ?? FolderFormModel();
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: FadeTransition(
            opacity: _animation,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(20.0),
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: const BoxDecoration(
                    color: CupertinoColors.lightBackgroundGray,
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'New list',
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Builder(builder: (context) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Provider.of<FolderFormModel>(context)
                                      .selectedPicker
                                      .color,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8.0))),
                              child: Icon(
                                Provider.of<FolderFormModel>(context)
                                    .selectedPicker
                                    .icon,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                            const Expanded(child: IconPickerListWidget()),
                          ],
                        );
                      }),
                    ),
                    Builder(builder: (context) {
                      return CupertinoTextField(
                        controller: _textController,
                        maxLines: 1,
                        placeholder: 'Enter name',
                        onChanged:
                            Provider.of<FolderFormModel>(context, listen: false)
                                .onTextChanged,
                        placeholderStyle: const TextStyle(
                            fontSize: 16,
                            color: CupertinoColors.placeholderText),
                        decoration: const BoxDecoration(),
                      );
                    }),
                    const SizedBox(height: 10),
                    FolderFormButtons(onClose: _remove)
                  ],
                ),
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
