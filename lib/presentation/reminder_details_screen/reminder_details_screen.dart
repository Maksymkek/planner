import 'package:flutter/cupertino.dart';
import 'package:planner/app_colors.dart';
import 'package:planner/domain/entity/reminder/reminder.dart';
import 'package:planner/extensions/datetime_extension.dart';
import 'package:planner/presentation/reminder_details_screen/contact_info_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ReminderDetailsScreen extends StatelessWidget {
  const ReminderDetailsScreen({super.key, required this.reminder});

  final Reminder reminder;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: Align(
            alignment: Alignment.topRight,
            child: CupertinoButton(
                child: const Text(
                  'Done',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ),
        ),
        Expanded(
          child: ListView(
              controller: ScrollController(initialScrollOffset: 0.1),
              physics: const BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 6, right: 6, bottom: 3),
                          child: SizedBox(
                            height: 40,
                            width: double.infinity,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                Text(
                                  reminder.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 34,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, bottom: 7),
                          child: Row(
                            children: [
                              Text(
                                '${DateTimeEx.getDay(reminder)} ${DateTimeEx.getTime(reminder)}',
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: CupertinoColors.systemGrey),
                              ),
                              const Spacer(),
                              const Icon(
                                CupertinoIcons.repeat,
                                color: CupertinoColors.systemGrey,
                                size: 12,
                              ),
                              const SizedBox(width: 3),
                              ConstrainedBox(
                                constraints:
                                    const BoxConstraints(maxWidth: 150),
                                child: Text(
                                  DateTimeEx.getRepeat(reminder),
                                  maxLines: 1,
                                  textAlign: TextAlign.end,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: CupertinoColors.systemGrey),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (reminder.description != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 6.0, horizontal: 10.0),
                                decoration: const BoxDecoration(
                                    color: AppColors.light,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(16.0))),
                                child: Text(reminder.description ?? '')),
                          ),
                        if (reminder.action != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: CupertinoButton(
                                color: AppColors.light,
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0)),
                                child: Row(
                                  children: [
                                    const Icon(
                                      CupertinoIcons.link,
                                      color: CupertinoColors.link,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 5),
                                    Expanded(
                                        child: Text(
                                      reminder.action!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: CupertinoColors.link),
                                    ))
                                  ],
                                ),
                                onPressed: () async {
                                  var actionUrl =
                                      Uri.parse(reminder.action ?? '');
                                  if (await canLaunchUrl(actionUrl)) {
                                    try {
                                      await launchUrl(actionUrl,
                                          mode: LaunchMode.inAppWebView);
                                    } catch (_) {}
                                  }
                                }),
                          ),
                        if (reminder.contacts != null) buildContactList()
                      ]),
                )
              ]),
        ),
      ],
    );
  }

  Widget buildContactList() {
    const double minSize = 43.0;
    final length = reminder.contacts?.length ?? 0;
    final height = length * minSize;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: (height > 129) ? 129 : height,
          child: Container(
            decoration: const BoxDecoration(
                color: AppColors.light,
                borderRadius: BorderRadius.all(Radius.circular(16.0))),
            child: RawScrollbar(
              padding: const EdgeInsets.only(top: 12, bottom: 12, right: 2),
              thickness: 4,
              thumbColor: CupertinoColors.systemGrey,
              radius: const Radius.circular(2.0),
              trackColor: CupertinoColors.black,
              thumbVisibility: true,
              child: ListView(
                  children: reminder.contacts!
                      .map((e) => ContactInfoWidget(contact: e))
                      .toList()),
            ),
          ),
        ),
      ],
    );
  }
}
