import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:move_on/core/services/notification_preferences_service.dart';
import 'package:move_on/features/profile/data/models/reminder_model.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationsService {
  static final LocalNotificationsService instance =
      LocalNotificationsService._internal();

  LocalNotificationsService._internal();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;

    tz.initializeTimeZones();

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidInit);

    await _plugin.initialize(initSettings);

    // Android 13+ runtime permission
    final android = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    await android?.requestNotificationsPermission();

    _initialized = true;
  }

  Future<void> cancelAllReminders() async {
    await init();
    // We only schedule reminder notifications using reminder.id as the notif id.
    // Best-effort: cancel everything scheduled by the app.
    await _plugin.cancelAll();
  }

  Future<void> showPushNotification({
    required String title,
    required String body,
    required NotificationPreferences prefs,
  }) async {
    await init();

    if (!prefs.general || prefs.doNotDisturb) return;

    await _plugin.show(
      DateTime.now().millisecondsSinceEpoch.remainder(1 << 31),
      title,
      body,
      _pushDetailsForPrefs(prefs),
    );
  }

  Future<void> scheduleReminders({
    required List<ReminderModel> reminders,
    required NotificationPreferences prefs,
  }) async {
    await init();

    if (!prefs.general || prefs.doNotDisturb || !prefs.reminders) {
      await cancelAllReminders();
      return;
    }

    // Reschedule cleanly to reflect updated prefs.
    await cancelAllReminders();

    for (final r in reminders) {
      final time = _parseTime(r.time);
      if (time == null) {
        if (kDebugMode) {
          log('⚠️ Could not parse reminder time: ${r.time}');
        }
        continue;
      }

      final scheduled = _nextInstanceOfTime(time.$1, time.$2);
      await _plugin.zonedSchedule(
        r.id,
        r.type,
        'It\'s time for ${r.type}',
        scheduled,
        _detailsForPrefs(prefs),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    }
  }

  NotificationDetails _detailsForPrefs(NotificationPreferences prefs) {
    // Note: On Android, sound/vibration behavior is tied to the channel.
    // Keeping a stable channel id means changes may not apply on some devices
    // until the user changes system settings. For most cases, rescheduling helps.
    final android = AndroidNotificationDetails(
      'move_on_reminders',
      'Reminders',
      channelDescription: 'Scheduled reminders from MoveOn',
      importance: Importance.high,
      priority: Priority.high,
      playSound: prefs.sound,
      enableVibration: prefs.vibrate,
      visibility: prefs.lockScreen
          ? NotificationVisibility.public
          : NotificationVisibility.secret,
    );
    return NotificationDetails(android: android);
  }

  NotificationDetails _pushDetailsForPrefs(NotificationPreferences prefs) {
    final android = AndroidNotificationDetails(
      'move_on_push',
      'General notifications',
      channelDescription: 'General notifications from MoveOn',
      importance: Importance.high,
      priority: Priority.high,
      playSound: prefs.sound,
      enableVibration: prefs.vibrate,
      visibility: prefs.lockScreen
          ? NotificationVisibility.public
          : NotificationVisibility.secret,
    );
    return NotificationDetails(android: android);
  }

  (int, int)? _parseTime(String raw) {
    // Accept: "HH:mm", "HH:mm:ss", and strings with whitespace.
    final cleaned = raw.trim();
    final parts = cleaned.split(':');
    if (parts.length < 2) return null;
    final h = int.tryParse(parts[0]);
    final m = int.tryParse(parts[1]);
    if (h == null || m == null) return null;
    if (h < 0 || h > 23 || m < 0 || m > 59) return null;
    return (h, m);
  }

  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }
}
