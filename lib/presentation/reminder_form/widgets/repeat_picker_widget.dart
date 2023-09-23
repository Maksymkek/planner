import 'package:flutter/cupertino.dart';
import 'package:planner/app_colors.dart';
import 'package:planner/domain/entity/reminder/reminder_replay.dart';
import 'package:planner/presentation/reminder_form/model/reminder_form_model.dart';
import 'package:planner/presentation/reminder_form/show_picker.dart';
import 'package:provider/provider.dart';

class RepeatPickerWidget extends StatelessWidget {
  const RepeatPickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(
          color: CupertinoColors.lightBackgroundGray,
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
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
              return;
              buildShowPicker(context);
            },
            child: Text(Provider.of<ReminderFormModel>(context).repeat.name),
          ),
        ],
      ),
    );
  }

  void buildShowPicker(BuildContext context) {
    return showPicker(
      context,
      CupertinoPicker(
          magnification: 1.22,
          squeeze: 1.2,
          useMagnifier: true,
          // This sets the initial item.
          scrollController: FixedExtentScrollController(
            initialItem: Provider.of<ReminderFormModel>(context, listen: false)
                .repeat
                .index,
          ),
          onSelectedItemChanged:
              Provider.of<ReminderFormModel>(context, listen: false)
                  .onRepeatPicked,
          itemExtent: 32.0,
          children: List<Widget>.generate(1, (int index) {
            return Center(child: Text(ReminderRepeat.never.name));
          })),
    );
  }
}
