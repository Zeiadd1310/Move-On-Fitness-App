import 'package:dartz/dartz.dart';
import 'package:move_on/core/errors/failures.dart';
import 'package:move_on/features/information/data/models/workout_plan_model.dart';

abstract class InformationRepo {
  Future<Either<Failure, WorkoutPlan>> generateWorkoutPlan({
    required int activityLevel,
    required String goal,
    required int availableDays,
  });
}
