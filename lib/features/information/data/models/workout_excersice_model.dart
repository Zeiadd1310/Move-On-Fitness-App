import 'package:equatable/equatable.dart';

class WorkoutExercise extends Equatable {
  final String exerciseName;
  final String muscleGroup;
  final String exerciseType;
  final int sets;
  final String reps;
  final String description;
  final String imageUrl;
  final String videoUrl;

  const WorkoutExercise({
    required this.exerciseName,
    required this.muscleGroup,
    required this.exerciseType,
    required this.sets,
    required this.reps,
    required this.description,
    required this.imageUrl,
    required this.videoUrl,
  });

  factory WorkoutExercise.fromJson(Map<String, dynamic> json) =>
      WorkoutExercise(
        exerciseName:
            (json['exercise_name'] ?? json['exerciseName'])?.toString() ?? '',
        muscleGroup:
            (json['muscle_group'] ?? json['muscleGroup'])?.toString() ?? '',
        exerciseType:
            (json['exercise_type'] ?? json['exerciseType'])?.toString() ?? '',
        sets: (json['sets'] as num?)?.toInt() ?? 0,
        reps: json['reps']?.toString() ?? '',
        description: json['description']?.toString() ?? '',
        imageUrl:
            (json['image_url'] ?? json['imageUrl'])?.toString() ?? '',
        videoUrl:
            (json['video_url'] ?? json['videoUrl'])?.toString() ?? '',
      );

  Map<String, dynamic> toJson() => {
        'exercise_name': exerciseName,
        'muscle_group': muscleGroup,
        'exercise_type': exerciseType,
        'sets': sets,
        'reps': reps,
        'description': description,
        'image_url': imageUrl,
        'video_url': videoUrl,
      };

  @override
  List<Object?> get props => [
        exerciseName,
        muscleGroup,
        exerciseType,
        sets,
        reps,
        description,
        imageUrl,
        videoUrl,
      ];
}
