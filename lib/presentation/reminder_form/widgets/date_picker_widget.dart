import 'package:flutter/cupertino.dart';
import 'package:planner/app_colors.dart';
import 'package:planner/presentation/reminder_form/model/reminder_form_model.dart';
import 'package:planner/presentation/reminder_form/show_picker.dart';
import 'package:planner/presentation/reminder_form/widgets/picker_container_widget.dart';
import 'package:provider/provider.dart';

class DatePickerWidget extends StatelessWidget {
  const DatePickerWidget(
      {super.key,
      required this.name,
      required this.text,
      required this.onChanged,
      required this.mode,
      required this.borderRadius,
      this.minimumDate});

  final String name;
  final String text;
  final DateTime? minimumDate;
  final Function(DateTime) onChanged;
  final CupertinoDatePickerMode mode;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return PickerContainerWidget(
      borderRadius: borderRadius,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              name,
              style: const TextStyle(
                  fontSize: 18,
                  color: AppColors.darkGrey,
                  fontWeight: FontWeight.w500),
            ),
          ),
          CupertinoButton(
            onPressed: () {
              showModalWindow(
                  context,
                  CupertinoDatePicker(
                    initialDateTime:
                        Provider.of<ReminderFormModel>(context, listen: false)
                            .remindTime,
                    mode: mode,
                    use24hFormat: true,
                    showDayOfWeek: true,
                    onDateTimeChanged: onChanged,
                  ),
                  260);
            },
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
