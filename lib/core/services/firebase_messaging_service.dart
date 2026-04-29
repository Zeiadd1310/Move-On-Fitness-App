import 'dart:async';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:move_on/core/services/local_notifications_service.dart';
import 'package:move_on/core/services/notification_preferences_service.dart';

class FirebaseMessagingService {
  static final FirebaseMessagingService instance =
      FirebaseMessagingService._internal();

  FirebaseMessagingService._internal();

  final NotificationPreferencesService _prefsService =
      NotificationPreferencesService();

  StreamSubscription<RemoteMessage>? _sub;
  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;

    // Permissions (mainly iOS, also Android 13+ handled by local notifications too)
    try {
      await FirebaseMessaging.instance.requestPermission();
    } catch (_) {}

    _sub = FirebaseMessaging.onMessage.listen(_onForegroundMessage);
    _initialized = true;
  }

  Future<void> dispose() async {
    await _sub?.cancel();
    _sub = null;
    _initialized = false;
  }

  Future<void> _onForegroundMessage(RemoteMessage message) async {
    final prefs = await _prefsService.load();

    // App-level "DND" + "General" should suppress foreground banners.
    if (!prefs.general || prefs.doNotDisturb) {
      if (kDebugMode) log('🔕 Suppressed FCM (general/dnd).');
      return;
    }

    final title =
        message.notification?.title ?? message.data['title']?.toString();
    final body = message.notification?.body ?? message.data['body']?.toString();
    if (title == null && body == null) return;

    await LocalNotificationsService.instance.showPushNotification(
      title: title ?? 'MoveOn',
      body: body ?? '',
      prefs: prefs,
    );
  }
}
