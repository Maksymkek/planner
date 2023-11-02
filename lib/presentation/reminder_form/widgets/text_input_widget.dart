import 'package:flutter/cupertino.dart';
import 'package:planner/presentation/reminder_form/widgets/picker_container_widget.dart';

class TextInputWidget extends StatelessWidget {
  const TextInputWidget(
      {super.key,
      required this.placeholder,
      required this.onChanged,
      required this.borderRadius,
      this.color,
      required this.text});

  final String placeholder;
  final String text;
  final Function(String) onChanged;
  final BorderRadius borderRadius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return PickerContainerWidget(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      borderRadius: borderRadius,
      child: CupertinoTextField(
        controller: TextEditingController(text: text),
        textCapitalization: TextCapitalization.sentences,
        style: TextStyle(color: color),
        maxLines: 1,
        placeholder: 'Enter ${placeholder.toLowerCase()}',
        decoration: const BoxDecoration(border: null),
        onChanged: onChanged,
      ),
    );
  }
}
