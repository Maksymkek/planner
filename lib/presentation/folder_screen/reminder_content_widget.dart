import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planner/domain/entity/reminder/reminder.dart';
import 'package:planner/extensions/datetime_extension.dart';
import 'package:planner/presentation/common_widgets/contact_preview/contact_list_preview.dart';
import 'package:planner/presentation/reminder_details_screen/reminder_details_screen.dart';
import 'package:planner/presentation/reminder_form/show_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class ReminderContentWidget extends StatefulWidget {
  const ReminderContentWidget({super.key, required this.reminder});

  final Reminder reminder;

  @override
  State<ReminderContentWidget> createState() => _ReminderContentWidgetState();
}

class _ReminderContentWidgetState extends State<ReminderContentWidget>
    with TickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> linkAnimation;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onDoubleTap: () async {
          await controller
              .forward()
              .whenComplete(() async => await controller.reverse());
          var actionUrl = Uri.parse(widget.reminder.action ?? '');
          if (await canLaunchUrl(actionUrl)) {
            try {
              await launchUrl(actionUrl, mode: LaunchMode.inAppWebView);
            } catch (_) {}
          }
        },
        onLongPress: () {
          showModalWindow(
              context,
              ReminderDetailsScreen(reminder: widget.reminder),
              double.infinity);
        },
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 2.5),
                Text(
                  widget.reminder.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                ),
                widget.reminder.description != null
                    ? Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Row(
                          children: [
                            const SizedBox(width: 1.5),
                            Expanded(
                              child: Text(
                                widget.reminder.description ?? '',
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
                        '${DateTimeEx.getDay(widget.reminder)}, ${DateTimeEx.getTime(widget.reminder)}',
                        maxLines: 1,
                        style:
                            const TextStyle(color: CupertinoColors.systemGrey),
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
            Positioned.fill(
                child: FadeTransition(
              opacity: linkAnimation,
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: ColoredBox(
                    color: Color.alphaBlend(
                        CupertinoColors.white.withOpacity(0.3),
                        CupertinoColors.activeBlue.withOpacity(0.1)),
                    child: const Center(
                      child: Icon(
                        CupertinoIcons.link,
                        color: CupertinoColors.link,
                        size: 40,
                      ),
                    ),
                  ),
                ),
              ),
            ))
          ],
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
            contacts: widget.reminder.contacts ?? [],
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
              DateTimeEx.getRepeat(widget.reminder),
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
    return (widget.reminder.action != null)
        ? const Padding(
            padding: EdgeInsets.only(left: 5),
            child: Icon(CupertinoIcons.link, size: 13),
          )
        : const SizedBox();
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 350));
    linkAnimation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
