import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:move_on/core/utils/helpers/month_utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pedometer/pedometer.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Live step count from the device [pedometer] plugin, with local daily history.
///
/// Raw values are typically cumulative since last boot; we normalize to calendar
/// days and persist totals. Device reboot mid-day is handled by adjusting the baseline.
class PedometerStepTracker {
  PedometerStepTracker();

  static const _prefsKey = 'pedometer_tracking_v1';
  static const _maxDailyEntries = 400;

  StreamSubscription<StepCount>? _subscription;
  bool _listening = false;

  bool get isListening => _listening;

  static bool get isSupported =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS);

  /// Android 10+ needs [ACTIVITY_RECOGNITION]. iOS relies on Info.plist motion string.
  static Future<bool> ensurePermission() async {
    if (kIsWeb) return false;
    if (defaultTargetPlatform == TargetPlatform.android) {
      final status = await Permission.activityRecognition.request();
      return status.isGranted;
    }
    return true;
  }

  String _ymd(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  Future<Map<String, dynamic>> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_prefsKey);
    if (raw == null || raw.isEmpty) return {};
    try {
      final decoded = jsonDecode(raw);
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is Map) {
        return decoded.map((k, v) => MapEntry(k.toString(), v));
      }
    } catch (_) {}
    return {};
  }

  Future<void> _save(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, jsonEncode(data));
  }

  /// Applies one [StepCount] event and persists. Returns UI snapshot.
  Future<PedometerSnapshot> applyStepCount(int raw) async {
    final persisted = await _load();
    final daily = _parseDaily(persisted['daily']);
    final baselineYmd = persisted['baselineYmd']?.toString() ?? '';
    var baselineRaw = (persisted['baselineRaw'] as num?)?.toInt() ?? 0;
    var lastRaw = (persisted['lastRaw'] as num?)?.toInt() ?? 0;
    final todayYmd = _ymd(DateTime.now());

    if (baselineYmd.isEmpty) {
      await _save({
        'baselineYmd': todayYmd,
        'baselineRaw': raw,
        'lastRaw': raw,
        'daily': _trimDaily({...daily, todayYmd: 0}),
      });
      return _snapshotFrom(todayYmd, 0, {...daily, todayYmd: 0});
    }

    if (todayYmd != baselineYmd) {
      final prevSteps = (lastRaw - baselineRaw).clamp(0, 1 << 30);
      daily[baselineYmd] = prevSteps;
      await _save({
        'baselineYmd': todayYmd,
        'baselineRaw': raw,
        'lastRaw': raw,
        'daily': _trimDaily({...daily, todayYmd: 0}),
      });
      return _snapshotFrom(todayYmd, 0, {...daily, todayYmd: 0});
    }

    if (raw < lastRaw) {
      final todaySoFar = (lastRaw - baselineRaw).clamp(0, 1 << 30);
      baselineRaw = raw - todaySoFar;
    }
    final todaySteps = (raw - baselineRaw).clamp(0, 1 << 30);
    daily[todayYmd] = todaySteps;

    await _save({
      'baselineYmd': todayYmd,
      'baselineRaw': baselineRaw,
      'lastRaw': raw,
      'daily': _trimDaily(Map<String, int>.from(daily)),
    });

    return _snapshotFrom(todayYmd, todaySteps, daily);
  }

  Map<String, int> _parseDaily(dynamic raw) {
    if (raw is! Map) return {};
    final out = <String, int>{};
    for (final e in raw.entries) {
      final k = e.key.toString();
      final v = e.value;
      final n = v is int ? v : (v is num ? v.toInt() : int.tryParse('$v') ?? 0);
      out[k] = n.clamp(0, 1 << 30);
    }
    return out;
  }

  Map<String, int> _trimDaily(Map<String, int> daily) {
    if (daily.length <= _maxDailyEntries) return daily;
    final keys = daily.keys.toList()..sort();
    final drop = keys.length - _maxDailyEntries;
    for (var i = 0; i < drop; i++) {
      daily.remove(keys[i]);
    }
    return daily;
  }

  PedometerSnapshot _snapshotFrom(
    String todayYmd,
    int todaySteps,
    Map<String, int> daily,
  ) {
    final merged = Map<String, int>.from(daily);
    merged[todayYmd] = todaySteps;
    return PedometerSnapshot(
      todaySteps: todaySteps,
      dailySteps: merged,
      recentDays: _recentThree(merged, todayYmd, todaySteps),
      chartData: _monthlyTotals(merged),
    );
  }

  List<PedometerDayRow> _recentThree(
    Map<String, int> daily,
    String todayYmd,
    int todaySteps,
  ) {
    final today = _parseYmd(todayYmd) ?? DateTime.now();
    final rows = <PedometerDayRow>[];
    for (var i = 0; i < 3; i++) {
      final d = DateTime(today.year, today.month, today.day - i);
      final key = _ymd(d);
      final steps = i == 0 ? todaySteps : (daily[key] ?? 0);
      rows.add(PedometerDayRow(date: d, steps: steps));
    }
    return rows;
  }

  DateTime? _parseYmd(String ymd) {
    final p = ymd.split('-');
    if (p.length != 3) return null;
    final y = int.tryParse(p[0]);
    final m = int.tryParse(p[1]);
    final d = int.tryParse(p[2]);
    if (y == null || m == null || d == null) return null;
    return DateTime(y, m, d);
  }

  List<Map<String, dynamic>> _monthlyTotals(Map<String, int> daily) {
    final now = DateTime.now();
    final out = <Map<String, dynamic>>[];
    for (var i = 3; i >= 0; i--) {
      final ref = DateTime(now.year, now.month - i, 1);
      final label = MonthUtils.getMonthName(ref.month).substring(0, 3);
      var sum = 0;
      for (final e in daily.entries) {
        final d = _parseYmd(e.key);
        if (d != null && d.year == ref.year && d.month == ref.month) {
          sum += e.value;
        }
      }
      out.add({'label': label, 'value': sum});
    }
    return out;
  }

  /// Load last persisted snapshot (no new sensor event).
  Future<PedometerSnapshot> loadSnapshot() async {
    final persisted = await _load();
    final daily = _parseDaily(persisted['daily']);
    final baselineYmd = persisted['baselineYmd']?.toString() ?? '';
    final baselineRaw = (persisted['baselineRaw'] as num?)?.toInt() ?? 0;
    final lastRaw = (persisted['lastRaw'] as num?)?.toInt() ?? 0;
    final todayYmd = _ymd(DateTime.now());

    if (baselineYmd.isEmpty) {
      return PedometerSnapshot(
        todaySteps: 0,
        dailySteps: daily,
        recentDays: _recentThree(daily, todayYmd, 0),
        chartData: _monthlyTotals(daily),
      );
    }

    if (todayYmd != baselineYmd) {
      // New day before first sensor event after midnight.
      return PedometerSnapshot(
        todaySteps: 0,
        dailySteps: daily,
        recentDays: _recentThree(daily, todayYmd, 0),
        chartData: _monthlyTotals(daily),
      );
    }

    final todaySteps = (lastRaw - baselineRaw).clamp(0, 1 << 30);
    return _snapshotFrom(todayYmd, todaySteps, daily);
  }

  Future<void> start(
    void Function(PedometerSnapshot snapshot) onData, {
    void Function(Object error)? onError,
  }) async {
    if (!isSupported || _listening) return;
    _listening = true;

    try {
      final initial = await loadSnapshot();
      onData(initial);
    } catch (_) {}

    _subscription = Pedometer.stepCountStream.listen(
      (StepCount event) async {
        try {
          final snap = await applyStepCount(event.steps);
          onData(snap);
        } catch (_) {}
      },
      onError: (Object e) {
        _listening = false;
        onError?.call(e);
      },
    );
  }

  Future<void> stop() async {
    await _subscription?.cancel();
    _subscription = null;
    _listening = false;
  }
}

class PedometerDayRow {
  const PedometerDayRow({required this.date, required this.steps});

  final DateTime date;
  final int steps;
}

class PedometerSnapshot {
  const PedometerSnapshot({
    required this.todaySteps,
    required this.dailySteps,
    required this.recentDays,
    required this.chartData,
    this.errorMessage,
    this.permissionDenied = false,
  });

  final int todaySteps;
  final Map<String, int> dailySteps;
  final List<PedometerDayRow> recentDays;
  final List<Map<String, dynamic>> chartData;
  final String? errorMessage;
  final bool permissionDenied;

  static String formatSteps(int n) {
    final s = n.toString();
    final buf = StringBuffer();
    for (var i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write(',');
      buf.write(s[i]);
    }
    return buf.toString();
  }

  /// Rough walk-time estimate (~100 steps/min).
  static String formatWalkDuration(int steps) {
    if (steps <= 0) return '--';
    final mins = (steps / 100).ceil().clamp(1, 24 * 60);
    final h = mins ~/ 60;
    final m = mins % 60;
    if (h > 0) return '${h}hr ${m}m';
    return '${m}m';
  }
}
