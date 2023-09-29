import 'package:flutter/cupertino.dart';
import 'package:planner/presentation/folder_form/folder_form_model.dart';
import 'package:planner/presentation/folder_form/icon_picker/icon_picker_model.dart';
import 'package:provider/provider.dart';

class IconPickerWidget extends StatelessWidget {
  const IconPickerWidget(this.iconPicker, {super.key});

  final IconPicker iconPicker;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: GestureDetector(
        onTap: () {
          Provider.of<FolderFormModel>(context, listen: false)
              .onPickerSelected(iconPicker);
        },
        child: Container(
          height: 25,
          width: 25,
          decoration: BoxDecoration(
              color: iconPicker.color,
              borderRadius: const BorderRadius.all(Radius.circular(6.0))),
          child: Icon(
            iconPicker.icon,
            size: 18,
            color: CupertinoColors.white,
          ),
        ),
      ),
    );
  }
}
