import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_on/features/information/data/models/workout_plan_model.dart';
import 'package:move_on/features/information/data/repos/information_repo.dart';

part 'generate_workout_plan_state.dart';

class GenerateWorkoutPlanCubit extends Cubit<GenerateWorkoutPlanState> {
  final InformationRepo informationRepo;

  GenerateWorkoutPlanCubit(this.informationRepo)
    : super(const GenerateWorkoutPlanInitial());

  Future<void> generateWorkoutPlan({
    required int activityLevel,
    required String goal,
    required int availableDays,
  }) async {
    emit(const GenerateWorkoutPlanLoading());

    final result = await informationRepo.generateWorkoutPlan(
      activityLevel: activityLevel,
      goal: goal,
      availableDays: availableDays,
    );

    result.fold(
      (failure) => emit(GenerateWorkoutPlanFailure(failure.errMessage)),
      (workoutPlan) => emit(GenerateWorkoutPlanSuccess(workoutPlan)),
    );
  }
}
