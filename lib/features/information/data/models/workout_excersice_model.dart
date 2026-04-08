import 'package:equatable/equatable.dart';

class WorkoutExercise extends Equatable {
  final String exerciseName;
  final String muscleGroup;
  final String exerciseType;
  final int sets;
  final String reps;

  const WorkoutExercise({
    required this.exerciseName,
    required this.muscleGroup,
    required this.exerciseType,
    required this.sets,
    required this.reps,
  });

  factory WorkoutExercise.fromJson(Map<String, dynamic> json) =>
      WorkoutExercise(
        exerciseName: json['exercise_name']?.toString() ?? '',
        muscleGroup: json['muscle_group']?.toString() ?? '',
        exerciseType: json['exercise_type']?.toString() ?? '',
        sets: (json['sets'] as num?)?.toInt() ?? 0,
        reps: json['reps']?.toString() ?? '',
      );

  Map<String, dynamic> toJson() => {
        'exercise_name': exerciseName,
        'muscle_group': muscleGroup,
        'exercise_type': exerciseType,
        'sets': sets,
        'reps': reps,
      };

  @override
  List<Object?> get props => [
        exerciseName,
        muscleGroup,
        exerciseType,
        sets,
        reps,
      ];
}
