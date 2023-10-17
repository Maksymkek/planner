import 'package:flutter/cupertino.dart';
import 'package:planner/app_colors.dart';
import 'package:planner/domain/entity/reminder/reminder_replay.dart';
import 'package:planner/presentation/reminder_form/model/reminder_form_model.dart';
import 'package:planner/presentation/reminder_form/show_picker.dart';
import 'package:planner/presentation/reminder_form/widgets/picker_container_widget.dart';
import 'package:provider/provider.dart';

class RepeatPickerWidget extends StatelessWidget {
  const RepeatPickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PickerContainerWidget(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Text(
              'Repeat',
              style: TextStyle(
                  fontSize: 18,
                  color: AppColors.darkGrey,
                  fontWeight: FontWeight.w500),
            ),
          ),
          CupertinoButton(
            onPressed: () {
              buildShowPicker(context);
            },
            child: Text(Provider.of<ReminderFormModel>(context).repeat.name),
          ),
        ],
      ),
    );
  }

  void buildShowPicker(BuildContext context) {
    return showModalWindow(
        context,
        CupertinoPicker(
            magnification: 1.22,
            squeeze: 1.2,
            useMagnifier: true,
            scrollController: FixedExtentScrollController(
              initialItem:
                  Provider.of<ReminderFormModel>(context, listen: false)
                      .repeat
                      .index,
            ),
            onSelectedItemChanged:
                Provider.of<ReminderFormModel>(context, listen: false)
                    .onRepeatPicked,
            itemExtent: 32.0,
            children: List<Widget>.generate(ReminderRepeat.values.length,
                (int index) {
              return Center(child: Text(ReminderRepeat.values[index].name));
            })),
        160);
  }
}
