import 'package:flutter/cupertino.dart';
import 'package:planner/app_colors.dart';
import 'package:planner/presentation/reminder_form/show_picker.dart';

class DatePickerWidget extends StatelessWidget {
  const DatePickerWidget(
      {super.key,
      required this.name,
      required this.text,
      required this.onChanged,
      required this.mode,
      required this.borderRadius});

  final String name;
  final String text;
  final Function(DateTime) onChanged;
  final CupertinoDatePickerMode mode;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: CupertinoColors.lightBackgroundGray,
          borderRadius: borderRadius),
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
              showPicker(
                context,
                CupertinoDatePicker(
                  initialDateTime: DateTime.now(),
                  mode: mode,
                  use24hFormat: true,
                  showDayOfWeek: true,
                  onDateTimeChanged: onChanged,
                ),
              );
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
