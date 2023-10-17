import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planner/domain/entity/reminder/reminder.dart';
import 'package:planner/extensions/datetime_extension.dart';
import 'package:planner/presentation/common_widgets/contact_preview/contact_list_preview.dart';
import 'package:url_launcher/url_launcher.dart';

class ReminderContentWidget extends StatelessWidget {
  const ReminderContentWidget({super.key, required this.reminder});

  final Reminder reminder;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onDoubleTap: () async {
          var actionUrl = Uri.parse(reminder.action ?? '');
          if (await canLaunchUrl(actionUrl)) {
            try {
              await launchUrl(actionUrl, mode: LaunchMode.inAppWebView);
            } catch (_) {}
          }
        },
        child: SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 2.5),
              Text(
                reminder.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              reminder.description != null
                  ? Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Row(
                        children: [
                          const SizedBox(width: 1.5),
                          Expanded(
                            child: Text(
                              reminder.description ?? '',
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
              SizedBox(
                height: 20,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                      '${DateTimeEx.getDay(reminder)}, ${DateTimeEx.getTime(reminder)}',
                      maxLines: 1,
                      style: const TextStyle(color: CupertinoColors.systemGrey),
                    ),
                    buildActionedMark(),
                    buildRightDock(),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
              const SizedBox(height: 3),
              const Divider(
                thickness: 0.5,
                color: Colors.grey,
                height: 0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded buildRightDock() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          ContactListPreviewWidget(
            contacts: reminder.contacts ?? [],
            size: 18,
          ),
          const SizedBox(width: 8),
          const Icon(
            CupertinoIcons.repeat,
            color: CupertinoColors.systemGrey,
            size: 12,
          ),
          const SizedBox(width: 3),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 150),
            child: Text(
              DateTimeEx.getRepeat(reminder),
              maxLines: 1,
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: CupertinoColors.systemGrey),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildActionedMark() {
    return (reminder.action != null)
        ? const Padding(
            padding: EdgeInsets.only(left: 5),
            child: Icon(CupertinoIcons.link, size: 13),
          )
        : const SizedBox();
  }
}
