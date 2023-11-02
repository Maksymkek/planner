import 'package:flutter/cupertino.dart';
import 'package:planner/app_colors.dart';
import 'package:planner/presentation/folder_form/icon_picker/icon_picker_model.dart';

class FolderFormModel extends ChangeNotifier {
  FolderFormModel({this.name = ''});

  String name;
  late IconPicker selectedPicker = iconPickers.first;
  static final List<IconPicker> iconPickers = [
    IconPicker(CupertinoIcons.gift_fill, AppColors.carmineRed),
    IconPicker(CupertinoIcons.person_2_fill, AppColors.lightBlue),
    IconPicker(CupertinoIcons.lightbulb_fill, AppColors.yellow),
    IconPicker(CupertinoIcons.list_bullet, AppColors.darkBlue),
    IconPicker(CupertinoIcons.location_fill, AppColors.lightBlue),
    IconPicker(CupertinoIcons.house_fill, AppColors.lightOrange),
    IconPicker(CupertinoIcons.book_fill, AppColors.lightPurple),
    IconPicker(CupertinoIcons.gear_solid, AppColors.darkGrey),
  ];

  void onPickerSelected(IconPicker picker) {
    selectedPicker = picker;
    notifyListeners();
  }

  void onTextChanged(String text) {
    name = text;
  }
}
