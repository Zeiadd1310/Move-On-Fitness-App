import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/services.dart';
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
      try {
        await _plugin.zonedSchedule(
          r.id,
          r.type,
          'It\'s time for ${r.type}',
          scheduled,
          _detailsForPrefs(prefs),
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          matchDateTimeComponents: DateTimeComponents.time,
        );
      } on PlatformException catch (e) {
        // Android 12+ may block exact alarms unless the user grants permission
        // (SCHEDULE_EXACT_ALARM / exact alarm access). Fall back to inexact mode.
        if (e.code == 'exact_alarms_not_permitted') {
          if (kDebugMode) {
            log('⚠️ Exact alarms not permitted; scheduling inexact for reminder ${r.id}.');
          }
          try {
            await _plugin.zonedSchedule(
              r.id,
              r.type,
              'It\'s time for ${r.type}',
              scheduled,
              _detailsForPrefs(prefs),
              androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
              matchDateTimeComponents: DateTimeComponents.time,
            );
          } on PlatformException catch (e2) {
            // Some OEMs/versions can still throw; don't crash the app.
            if (kDebugMode) {
              log('⚠️ Failed to schedule inexact reminder ${r.id}: ${e2.code}');
            }
          } catch (e2) {
            if (kDebugMode) {
              log('⚠️ Failed to schedule inexact reminder ${r.id}: $e2');
            }
          }
        } else {
          if (kDebugMode) {
            log('⚠️ Failed to schedule reminder ${r.id}: ${e.code}');
          }
        }
      } catch (e) {
        // Never crash the app due to scheduling failures.
        if (kDebugMode) {
          log('⚠️ Failed to schedule reminder ${r.id}: $e');
        }
      }
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
    // Accept:
    // - "HH:mm" / "H:mm"
    // - "HH:mm:ss"
    // - "hh:mm AM" / "hh:mm PM" (backend format)
    final cleaned = raw.trim();
    if (cleaned.isEmpty) return null;

    // 12-hour with AM/PM, e.g. "08:00 AM", "1:05 pm"
    final ampm = RegExp(r'^(\d{1,2}):(\d{2})(?::\d{2})?\s*([aApP][mM])$');
    final m12 = ampm.firstMatch(cleaned);
    if (m12 != null) {
      var hour = int.tryParse(m12.group(1)!);
      final minute = int.tryParse(m12.group(2)!);
      final meridiem = m12.group(3)!.toLowerCase();
      if (hour == null || minute == null) return null;
      if (hour < 1 || hour > 12 || minute < 0 || minute > 59) return null;

      // Convert 12h → 24h
      if (meridiem == 'am') {
        if (hour == 12) hour = 0;
      } else {
        if (hour != 12) hour += 12;
      }
      return (hour, minute);
    }

    // 24-hour format "HH:mm" or "HH:mm:ss"
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
