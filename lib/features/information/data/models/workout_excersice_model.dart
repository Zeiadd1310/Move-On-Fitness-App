import 'package:equatable/equatable.dart';
import 'package:move_on/core/utils/functions/media_url.dart';

class WorkoutExercise extends Equatable {
  final String exerciseName;
  final String muscleGroup;
  final String exerciseType;
  final int sets;
  final String reps;
  final String description;
  final String imageUrl;
  final String videoUrl;
  final String duration;
  final num calories;

  const WorkoutExercise({
    required this.exerciseName,
    required this.muscleGroup,
    required this.exerciseType,
    required this.sets,
    required this.reps,
    required this.description,
    required this.imageUrl,
    required this.videoUrl,
    required this.duration,
    required this.calories,
  });

  static String _readString(dynamic value) {
    final text = value?.toString().trim() ?? '';
    if (text.isEmpty || text.toLowerCase() == 'null') return '';
    return text;
  }

  static num _readNum(dynamic value) {
    if (value is num) return value;
    final parsed = num.tryParse(value?.toString() ?? '');
    return parsed ?? 0;
  }

  factory WorkoutExercise.fromJson(Map<String, dynamic> json) =>
      WorkoutExercise(
        exerciseName: _readString(json['exercise_name'] ?? json['exerciseName']),
        muscleGroup: _readString(json['muscle_group'] ?? json['muscleGroup']),
        exerciseType: _readString(json['exercise_type'] ?? json['exerciseType']),
        sets: (json['sets'] as num?)?.toInt() ?? 0,
        reps: _readString(json['reps']),
        description: _readString(json['description']),
        imageUrl: normalizeApiMediaUrl(
          _readString(json['image_url'] ?? json['imageUrl']),
        ),
        videoUrl: _readString(json['video_url'] ?? json['videoUrl']),
        duration: (json['duration'] ??
                    json['estimated_duration'] ??
                    json['estimatedDuration'] ??
                    json['time'])
                ?.toString() ??
            '',
        calories: _readNum(json['calories'] ?? json['kcal']),
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
    'duration': duration,
    'calories': calories,
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
    duration,
    calories,
  ];
}
