import 'package:flutter/material.dart';
import 'package:move_on/features/information/data/models/workout_excersice_model.dart';
import 'package:move_on/features/workout/presentation/views/widgets/about_workout_view_body.dart';

class AboutWorkoutView extends StatelessWidget {
  const AboutWorkoutView({
    super.key,
    required this.exercise,
    required this.dayType,
  });

  final WorkoutExercise exercise;
  final String dayType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: AboutWorkoutViewBody(exercise: exercise, dayType: dayType));
  }
}
