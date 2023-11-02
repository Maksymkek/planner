import 'dart:async';
import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:planner/domain/entity/folder/folder.dart';
import 'package:planner/domain/entity/reminder/reminder.dart';
import 'package:planner/domain/entity/reminder/reminder_replay.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:url_launcher/url_launcher.dart';

class AppNotification {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final _dateTimeComponents = {
    ReminderRepeat.day: DateTimeComponents.time,
    ReminderRepeat.month: DateTimeComponents.dayOfMonthAndTime,
    ReminderRepeat.week: DateTimeComponents.dayOfWeekAndTime,
    ReminderRepeat.never: DateTimeComponents.dateAndTime,
  };

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('img');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      notificationCategories: [
        DarwinNotificationCategory(
          'demoCategory',
          actions: <DarwinNotificationAction>[
            DarwinNotificationAction.plain('id_1', 'Action 1'),
            DarwinNotificationAction.plain(
              'id_2',
              'Action 2',
              options: <DarwinNotificationActionOption>{
                DarwinNotificationActionOption.destructive,
              },
            ),
            DarwinNotificationAction.plain(
              'id_3',
              'Action 3',
              options: <DarwinNotificationActionOption>{
                DarwinNotificationActionOption.foreground,
              },
            ),
          ],
          options: <DarwinNotificationCategoryOption>{
            DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
          },
        )
      ],
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveLocalNotification,
      onDidReceiveBackgroundNotificationResponse: onDidReceiveLocalNotification,
    );
  }

  static void onDidReceiveLocalNotification(
      NotificationResponse notificationResponse) async {
    if (notificationResponse.payload != null) {
      var actionUrl = Uri.parse(notificationResponse.payload ?? '');
      if (await canLaunchUrl(actionUrl)) {
        try {
          launchUrl(actionUrl, mode: LaunchMode.inAppWebView);
        } catch (_) {}
      }
    }
  }

  Future<bool> requestPermissions() async {
    if (Platform.isIOS) {
      final bool? permission = await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      return permission ?? false;
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      final bool? permission = await androidImplementation?.requestPermission();
      return permission ?? false;
    }
    return false;
  }

  Future<bool> setNotification(Reminder reminder, Folder folder) async {
    if (!await requestPermissions()) {
      return false;
    }
    tz.initializeTimeZones();
    final tz.TZDateTime scheduledAt =
        tz.TZDateTime.from(reminder.time, tz.local);
    try {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        reminder.id.hashCode,
        folder.title,
        reminder.title,
        scheduledAt,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'ScheduleNotification001',
            'NotifyMe',
            ongoing: true,
          ),
        ),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        payload: reminder.action,
        matchDateTimeComponents: _dateTimeComponents[reminder.repeat],
      );
    } catch (_) {
      return false;
    }
    return true;
  }

  /// Cancels notification with appointed id.
  ///
  /// if [delayed} is true, then canceling will be after 2 minutes
  Future<void> cancelNotification(String reminderId,
      {bool delayed = false}) async {
    try {
      if (delayed) {
        await Future.delayed(const Duration(minutes: 2));
      }
      await flutterLocalNotificationsPlugin.cancel(reminderId.hashCode);
    } catch (_) {}
  }
}
