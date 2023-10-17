import 'package:flutter/cupertino.dart';
import 'package:planner/presentation/reminder_form/model/reminder_form_model.dart';
import 'package:provider/provider.dart';

class ReminderFormErrorWidget extends StatefulWidget {
  const ReminderFormErrorWidget({super.key});

  @override
  State<ReminderFormErrorWidget> createState() =>
      _ReminderFormErrorWidgetState();
}

class _ReminderFormErrorWidgetState extends State<ReminderFormErrorWidget> {
  double errorAnimation = 0.0;
  String errorMessage = 'Something went wrong';

  @override
  Widget build(BuildContext context) {
    final error = Provider.of<ReminderFormModel>(context).errorMessage;
    if (error == null) {
      errorAnimation = 0.0;
    } else {
      errorAnimation = 14.0;
      errorMessage = error;
    }
    return TweenAnimationBuilder(
        curve: Curves.fastOutSlowIn,
        tween: Tween(begin: 0.0, end: errorAnimation),
        duration: const Duration(milliseconds: 250),
        builder: (context, size, child) {
          return Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 2),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    errorMessage,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: CupertinoColors.destructiveRed, fontSize: size),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
