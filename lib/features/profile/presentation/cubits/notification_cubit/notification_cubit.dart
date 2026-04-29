import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_on/core/services/local_notifications_service.dart';
import 'package:move_on/core/services/local_storage_service.dart';
import 'package:move_on/core/services/notification_preferences_service.dart';
import 'package:move_on/features/profile/data/models/reminder_model.dart';
import '../../../data/repos/notification_repo.dart';
import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepo repo;
  final NotificationPreferencesService _prefsService;
  final LocalNotificationsService _localNotifs;

  NotificationCubit(
    this.repo, {
    NotificationPreferencesService? prefsService,
    LocalNotificationsService? localNotifs,
  }) : _prefsService = prefsService ?? NotificationPreferencesService(),
       _localNotifs = localNotifs ?? LocalNotificationsService.instance,
       super(NotificationInitial());

  NotificationPreferences _prefs = const NotificationPreferences.defaults();
  List<ReminderModel> _reminders = const [];
  String? _authToken;

  Future<void> loadReminders(String token) async {
    emit(NotificationLoading());
    final result = await repo.getReminders(token: token);
    result.fold(
      (f) {
        emit(NotificationError(f.errMessage));
        // Keep UI usable with persisted prefs even on fetch failure.
        emit(NotificationLoaded(reminders: _reminders, prefs: _prefs));
      },
      (data) {
        _reminders = data;
        emit(NotificationLoaded(reminders: _reminders, prefs: _prefs));
      },
    );
  }

  Future<void> init() async {
    _prefs = await _prefsService.load();
    emit(NotificationLoaded(reminders: _reminders, prefs: _prefs));

    final token = await LocalStorageService().getToken();
    final sanitized = token?.trim();
    log('🔑 NOTIFICATION TOKEN: $sanitized');
    if (sanitized == null || sanitized.isEmpty) {
      _authToken = null;
      await _applyScheduling();
      return;
    }

    _authToken = sanitized;
    await registerFcmToken(sanitized);
    await loadReminders(sanitized);
    await _applyScheduling();
  }

  Future<void> registerFcmToken(String authToken) async {
    try {
      final messaging = FirebaseMessaging.instance;
      await messaging.requestPermission();
      final fcmToken = await messaging.getToken();
      if (fcmToken != null) {
        await repo.registerFcmToken(fcmToken, token: authToken);
      }
    } catch (_) {}
  }

  Future<void> setGeneral(bool value) async {
    _prefs = _prefs.copyWith(general: value);
    await _prefsService.save(_prefs);
    emit(NotificationLoaded(reminders: _reminders, prefs: _prefs));
    await _applyScheduling();
  }

  Future<void> setSound(bool value) async {
    _prefs = _prefs.copyWith(sound: value);
    await _prefsService.save(_prefs);
    emit(NotificationLoaded(reminders: _reminders, prefs: _prefs));
    await _applyScheduling();
  }

  Future<void> setDoNotDisturb(bool value) async {
    _prefs = _prefs.copyWith(doNotDisturb: value);
    await _prefsService.save(_prefs);
    emit(NotificationLoaded(reminders: _reminders, prefs: _prefs));
    await _applyScheduling();
  }

  Future<void> setVibrate(bool value) async {
    _prefs = _prefs.copyWith(vibrate: value);
    await _prefsService.save(_prefs);
    emit(NotificationLoaded(reminders: _reminders, prefs: _prefs));
    await _applyScheduling();
  }

  Future<void> setLockScreen(bool value) async {
    _prefs = _prefs.copyWith(lockScreen: value);
    await _prefsService.save(_prefs);
    emit(NotificationLoaded(reminders: _reminders, prefs: _prefs));
    await _applyScheduling();
  }

  Future<void> setReminders(bool value) async {
    _prefs = _prefs.copyWith(reminders: value);
    await _prefsService.save(_prefs);
    emit(NotificationLoaded(reminders: _reminders, prefs: _prefs));

    // If enabling reminders and we have auth, ensure reminders list is loaded first.
    if (value && _authToken != null && _reminders.isEmpty) {
      await loadReminders(_authToken!);
    }
    await _applyScheduling();
  }

  Future<void> _applyScheduling() async {
    // App-level switches:
    // - general off => cancel everything
    // - DND on => cancel reminders
    // - reminders off => cancel reminders
    if (!_prefs.general || _prefs.doNotDisturb || !_prefs.reminders) {
      await _localNotifs.cancelAllReminders();
      return;
    }

    // Schedule reminders if we have any.
    if (_reminders.isNotEmpty) {
      await _localNotifs.scheduleReminders(
        reminders: _reminders,
        prefs: _prefs,
      );
    } else {
      // Nothing to schedule, but ensure old schedules are cleared.
      await _localNotifs.cancelAllReminders();
    }
  }
}
