import 'package:flutter/cupertino.dart';

class TextInputWidget extends StatelessWidget {
  const TextInputWidget({
    super.key,
    required this.text,
    required this.onChanged,
    required this.borderRadius,
  });

  final String text;
  final Function(String) onChanged;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
          color: CupertinoColors.lightBackgroundGray,
          borderRadius: borderRadius),
      child: Column(
        children: [
          const SizedBox(height: 5),
          CupertinoTextField(
            placeholder: 'Enter ${text.toLowerCase()}',
            decoration: const BoxDecoration(border: null),
            onChanged: onChanged,
          )
        ],
      ),
    );
  }
}
