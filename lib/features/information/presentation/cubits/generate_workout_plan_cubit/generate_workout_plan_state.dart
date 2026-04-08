part of 'generate_workout_plan_cubit.dart';

sealed class GenerateWorkoutPlanState extends Equatable {
  const GenerateWorkoutPlanState();

  @override
  List<Object?> get props => [];
}

final class GenerateWorkoutPlanInitial extends GenerateWorkoutPlanState {
  const GenerateWorkoutPlanInitial();
}

final class GenerateWorkoutPlanLoading extends GenerateWorkoutPlanState {
  const GenerateWorkoutPlanLoading();
}

final class GenerateWorkoutPlanSuccess extends GenerateWorkoutPlanState {
  final WorkoutPlan workoutPlan;
  const GenerateWorkoutPlanSuccess(this.workoutPlan);

  @override
  List<Object?> get props => [workoutPlan];
}

final class GenerateWorkoutPlanFailure extends GenerateWorkoutPlanState {
  final String errorMessage;
  const GenerateWorkoutPlanFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
