import 'package:shared_preferences/shared_preferences.dart';

class NotificationPreferences {
  final bool general;
  final bool sound;
  final bool doNotDisturb;
  final bool vibrate;
  final bool lockScreen;
  final bool reminders;

  const NotificationPreferences({
    required this.general,
    required this.sound,
    required this.doNotDisturb,
    required this.vibrate,
    required this.lockScreen,
    required this.reminders,
  });

  const NotificationPreferences.defaults()
      : general = true,
        sound = true,
        doNotDisturb = false,
        vibrate = true,
        lockScreen = true,
        reminders = true;

  NotificationPreferences copyWith({
    bool? general,
    bool? sound,
    bool? doNotDisturb,
    bool? vibrate,
    bool? lockScreen,
    bool? reminders,
  }) {
    return NotificationPreferences(
      general: general ?? this.general,
      sound: sound ?? this.sound,
      doNotDisturb: doNotDisturb ?? this.doNotDisturb,
      vibrate: vibrate ?? this.vibrate,
      lockScreen: lockScreen ?? this.lockScreen,
      reminders: reminders ?? this.reminders,
    );
  }
}

class NotificationPreferencesService {
  static const _kGeneral = 'notif_general';
  static const _kSound = 'notif_sound';
  static const _kDnd = 'notif_dnd';
  static const _kVibrate = 'notif_vibrate';
  static const _kLockScreen = 'notif_lock_screen';
  static const _kReminders = 'notif_reminders';

  Future<NotificationPreferences> load() async {
    final prefs = await SharedPreferences.getInstance();
    final defaults = const NotificationPreferences.defaults();
    return NotificationPreferences(
      general: prefs.getBool(_kGeneral) ?? defaults.general,
      sound: prefs.getBool(_kSound) ?? defaults.sound,
      doNotDisturb: prefs.getBool(_kDnd) ?? defaults.doNotDisturb,
      vibrate: prefs.getBool(_kVibrate) ?? defaults.vibrate,
      lockScreen: prefs.getBool(_kLockScreen) ?? defaults.lockScreen,
      reminders: prefs.getBool(_kReminders) ?? defaults.reminders,
    );
  }

  Future<void> save(NotificationPreferences value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kGeneral, value.general);
    await prefs.setBool(_kSound, value.sound);
    await prefs.setBool(_kDnd, value.doNotDisturb);
    await prefs.setBool(_kVibrate, value.vibrate);
    await prefs.setBool(_kLockScreen, value.lockScreen);
    await prefs.setBool(_kReminders, value.reminders);
  }
}

