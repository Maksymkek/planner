import 'package:flutter/cupertino.dart';
import 'package:planner/presentation/reminder_form/widgets/picker_container_widget.dart';

class TextInputWidget extends StatelessWidget {
  const TextInputWidget(
      {super.key,
      required this.text,
      required this.onChanged,
      required this.borderRadius,
      this.color});

  final String text;
  final Function(String) onChanged;
  final BorderRadius borderRadius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return PickerContainerWidget(
      padding: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 10),
      borderRadius: borderRadius,
      child: Column(
        children: [
          const SizedBox(height: 5),
          CupertinoTextField(
            textCapitalization: TextCapitalization.sentences,
            style: TextStyle(color: color),
            maxLines: 1,
            placeholder: 'Enter ${text.toLowerCase()}',
            decoration: const BoxDecoration(border: null),
            onChanged: onChanged,
          )
        ],
      ),
    );
  }
}
