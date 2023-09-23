import 'dart:async';
import 'dart:io';

import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:planner/domain/entity/folder/folder.dart';
import 'package:planner/domain/entity/reminder/reminder.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class AppNotification {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final FlutterBackgroundService service = FlutterBackgroundService();
  bool _isGranted = false;

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
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveLocalNotification,
        onDidReceiveBackgroundNotificationResponse:
            onDidReceiveBackgroundNotificationResponse);
  }

  static void onDidReceiveBackgroundNotificationResponse(
      NotificationResponse notificationResponse) {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
  }

  static void onDidReceiveLocalNotification(
      NotificationResponse notificationResponse) {}

  Future<bool> requestPermissions() async {
    if (_isGranted) return true;
    if (Platform.isIOS) {
      final bool? permission = await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      _isGranted = permission ?? false;
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      final bool? permission = await androidImplementation?.requestPermission();
      _isGranted = permission ?? false;
    }
    return _isGranted;
  }

  Future<void> setNotification(Reminder reminder, Folder folder) async {
    if (!await requestPermissions()) {
      return;
    }

    tz.initializeTimeZones();
    final tz.TZDateTime scheduledAt =
        tz.TZDateTime.from(reminder.time, tz.local);

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
    );
  }

  Future<void> cancelNotification(String reminderId) async {
    try {
      await flutterLocalNotificationsPlugin.cancel(reminderId.hashCode);
    } catch (_) {}
  }
}
