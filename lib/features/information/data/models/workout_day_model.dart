import 'package:equatable/equatable.dart';
import 'package:move_on/features/information/data/models/workout_excersice_model.dart';

class WorkoutDay extends Equatable {
  final String dayKey; // "day1", "day2", ...
  final String dayType; // "Chest & Triceps", "Legs", ...
  final List<WorkoutExercise> exercises;

  const WorkoutDay({
    required this.dayKey,
    required this.dayType,
    required this.exercises,
  });

  factory WorkoutDay.fromJson(String key, Map<String, dynamic> json) =>
      WorkoutDay(
        dayKey: key,
        dayType: json['day_type']?.toString() ?? '',
        exercises: (json['workout'] as List? ?? [])
            .map((e) => WorkoutExercise.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'day_type': dayType,
        'workout': exercises.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props => [
        dayKey,
        dayType,
        exercises,
      ];
}
