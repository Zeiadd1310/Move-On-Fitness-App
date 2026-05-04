import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_on/features/nutrition/data/models/meals_model/meals_model.dart';
import 'package:move_on/features/nutrition/data/repos/nutrition_repo.dart';

part 'generate_nutrition_plan_state.dart';

class GenerateNutritionPlanCubit extends Cubit<GenerateNutritionPlanState> {
  final NutritionRepo nutritionRepo;

  GenerateNutritionPlanCubit(this.nutritionRepo)
    : super(const GenerateNutritionPlanInitial());

  Future<void> loadOrGenerateNutritionPlan({bool forceRefresh = false}) async {
    if (!forceRefresh) {
      final cached = await nutritionRepo.loadCachedNutritionPlan();
      if (cached != null) {
        emit(GenerateNutritionPlanSuccess(cached));
        return;
      }
    }

    emit(const GenerateNutritionPlanLoading());
    final result = await nutritionRepo.generateNutritionPlan();
    result.fold(
      (failure) => emit(GenerateNutritionPlanFailure(failure.errMessage)),
      (plan) => emit(GenerateNutritionPlanSuccess(plan)),
    );
  }
}
