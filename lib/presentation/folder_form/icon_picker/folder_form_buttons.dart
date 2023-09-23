import 'package:flutter/cupertino.dart';
import 'package:planner/domain/entity/folder/folder.dart';
import 'package:planner/presentation/common_widgets/app_button.dart';
import 'package:planner/presentation/folder_form/folder_form.dart';
import 'package:planner/presentation/folder_form/folder_form_model.dart';
import 'package:planner/presentation/router.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class FolderFormButtons extends StatelessWidget {
  const FolderFormButtons({super.key, required this.onClose});

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppButtonWidget(
          onPressed: onClose,
          text: 'Cancel',
        ),
        AppButtonWidget(
          onPressed: () {
            onClose();
            var folder = Folder(
                id: const Uuid().v1(),
                title:
                    Provider.of<FolderFormModel>(context, listen: false).name,
                background: Provider.of<FolderFormModel>(context, listen: false)
                    .selectedPicker
                    .color,
                icon: Provider.of<FolderFormModel>(context, listen: false)
                    .selectedPicker
                    .icon,
                reminders: []);
            FolderFormWidget.formKey.currentState?.onDone(folder).whenComplete(
                () => Navigator.pushNamed(context, Routes.folderPage,
                    arguments: folder));
          },
          text: 'Done',
        )
      ],
    );
  }
}
