import 'package:equatable/equatable.dart';
import 'package:move_on/features/information/data/models/warmup_cooldown_item_model.dart';
import 'package:move_on/features/information/data/models/workout_day_model.dart';

class WorkoutWeek extends Equatable {
  final int weekNumber;
  final String phase;
  final List<WarmupCooldownItem> warmup;
  final List<WarmupCooldownItem> cooldown;
  final List<WorkoutDay> days;
  final List<String> notes;

  const WorkoutWeek({
    required this.weekNumber,
    required this.phase,
    required this.warmup,
    required this.cooldown,
    required this.days,
    required this.notes,
  });

  factory WorkoutWeek.fromJson(Map<String, dynamic> json) {
    final dynamic rawDays = json['days'];
    final daysMap = rawDays is Map<String, dynamic>
        ? rawDays
        : rawDays is Map
        ? rawDays.map((k, v) => MapEntry(k.toString(), v))
        : <String, dynamic>{};

    final sortedEntries = daysMap.entries.toList()
      ..sort((a, b) {
        int parseDay(String key) {
          final match = RegExp(r'\d+').firstMatch(key);
          if (match == null) return 0;
          return int.tryParse(match.group(0) ?? '') ?? 0;
        }

        return parseDay(a.key).compareTo(parseDay(b.key));
      });

    final days = sortedEntries
        .map((e) => WorkoutDay.fromJson(e.key, e.value as Map<String, dynamic>))
        .toList();

    return WorkoutWeek(
      weekNumber:
          ((json['week_number'] ?? json['weekNumber']) as num?)?.toInt() ?? 0,
      phase: json['phase']?.toString() ?? '',
      warmup: (json['warmup'] as List? ?? [])
          .map((e) => WarmupCooldownItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      cooldown: (json['cooldown'] as List? ?? [])
          .map((e) => WarmupCooldownItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      notes: (json['notes'] as List? ?? []).map((e) => e.toString()).toList(),
      days: days,
    );
  }

  Map<String, dynamic> toJson() => {
    'week_number': weekNumber,
    'phase': phase,
    'warmup': warmup.map((w) => w.toJson()).toList(),
    'cooldown': cooldown.map((c) => c.toJson()).toList(),
    'notes': notes,
    'days': {for (final day in days) day.dayKey: day.toJson()},
  };

  @override
  List<Object?> get props => [weekNumber, phase, warmup, cooldown, days, notes];
}
