import 'package:flutter/cupertino.dart';
import 'package:planner/presentation/folder_form/folder_form_model.dart';
import 'package:planner/presentation/folder_form/icon_picker/icon_picker.dart';

class IconPickerListWidget extends StatefulWidget {
  const IconPickerListWidget({super.key});

  @override
  State<IconPickerListWidget> createState() => _IconPickerListWidgetState();
}

class _IconPickerListWidgetState extends State<IconPickerListWidget> {
  final ScrollController controller =
      ScrollController(initialScrollOffset: 0.1);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        child: SizedBox(
          height: 28,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            controller: ScrollController(initialScrollOffset: 0.1),
            physics: const BouncingScrollPhysics(),
            itemCount: FolderFormModel.iconPickers.length,
            itemBuilder: (BuildContext context, int index) {
              return IconPickerWidget(FolderFormModel.iconPickers[index]);
            },
          ),
        ),
      ),
    );
  }
}
