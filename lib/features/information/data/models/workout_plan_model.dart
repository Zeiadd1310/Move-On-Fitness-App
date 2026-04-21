import 'package:equatable/equatable.dart';
import 'package:move_on/features/information/data/models/workout_week_model.dart';

class WorkoutPlan extends Equatable {
  final String userId;
  final String userName;
  final String fitnessLevel;
  final String goal;
  final int availableDays;
  final DateTime generatedAt;
  final List<WorkoutWeek> weeks;

  const WorkoutPlan({
    required this.userId,
    required this.userName,
    required this.fitnessLevel,
    required this.goal,
    required this.availableDays,
    required this.generatedAt,
    required this.weeks,
  });

  factory WorkoutPlan.fromJson(Map<String, dynamic> json) {
    final rawGeneratedAt = (json['generated_at'] ?? json['generatedAt'])
        ?.toString();
    final rawWeeks = json['weeks'] as List? ?? const [];

    return WorkoutPlan(
      userId: json['user_id']?.toString() ?? '',
      userName: (json['user_name'] ?? json['userName'])?.toString() ?? '',
      fitnessLevel:
          (json['fitness_level'] ?? json['fitnessLevel'])?.toString() ?? '',
      goal: json['goal']?.toString() ?? '',
      availableDays:
          ((json['available_days'] ?? json['availableDays']) as num?)
              ?.toInt() ??
          0,
      generatedAt: rawGeneratedAt != null && rawGeneratedAt.isNotEmpty
          ? DateTime.tryParse(rawGeneratedAt) ??
                DateTime.fromMillisecondsSinceEpoch(0)
          : DateTime.fromMillisecondsSinceEpoch(0),
      weeks: rawWeeks
          .whereType<Map<String, dynamic>>()
          .map(WorkoutWeek.fromJson)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'user_name': userName,
    'fitness_level': fitnessLevel,
    'goal': goal,
    'available_days': availableDays,
    'generated_at': generatedAt.toIso8601String(),
    'weeks': weeks.map((w) => w.toJson()).toList(),
  };

  @override
  List<Object?> get props => [
    userId,
    userName,
    fitnessLevel,
    goal,
    availableDays,
    generatedAt,
    weeks,
  ];
}
