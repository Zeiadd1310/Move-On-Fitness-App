import 'package:equatable/equatable.dart';
import 'package:move_on/core/utils/functions/media_url.dart';
import 'package:move_on/features/information/data/models/workout_excersice_model.dart';

class WorkoutDay extends Equatable {
  final String dayKey; // "day1", "day2", ...
  final String dayType; // "Chest & Triceps", "Legs", ...
  final String dayImageUrl;
  final Map<String, String> variations;
  final List<WorkoutExercise> exercises;

  const WorkoutDay({
    required this.dayKey,
    required this.dayType,
    required this.dayImageUrl,
    required this.variations,
    required this.exercises,
  });

  /// Uses API cover first, then the first exercise image as fallback.
  String get coverDisplayPath {
    if (dayImageUrl.isNotEmpty) return dayImageUrl;
    if (exercises.isNotEmpty) return exercises.first.imageUrl;
    return '';
  }

  factory WorkoutDay.fromJson(String key, Map<String, dynamic> json) {
    final rawVariations = json['variations'];
    final variationsMap = rawVariations is Map
        ? rawVariations.map(
            (k, v) => MapEntry(k.toString(), v?.toString() ?? ''),
          )
        : <String, String>{};

    return WorkoutDay(
      dayKey: key,
      dayType: (json['day_type'] ?? json['dayType'])?.toString() ?? '',
      dayImageUrl: normalizeApiMediaUrl(
        (json['day_image_url'] ?? json['dayImageUrl'])?.toString(),
      ),
      variations: variationsMap,
      exercises: (json['workout'] as List? ?? [])
          .whereType<Map<String, dynamic>>()
          .map(WorkoutExercise.fromJson)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'day_type': dayType,
    'day_image_url': dayImageUrl,
    'variations': variations,
    'workout': exercises.map((e) => e.toJson()).toList(),
  };

  @override
  List<Object?> get props => [
    dayKey,
    dayType,
    dayImageUrl,
    variations,
    exercises,
  ];
}
