import 'package:flutter/material.dart';
import 'package:move_on/features/information/data/models/workout_day_model.dart';
import 'package:move_on/features/workout/presentation/views/widgets/workout_details_view_body.dart';

class WorkoutDetailsView extends StatelessWidget {
  const WorkoutDetailsView({super.key, required this.day});

  final WorkoutDay day;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: WorkoutDetailsViewBody(day: day));
  }
}
