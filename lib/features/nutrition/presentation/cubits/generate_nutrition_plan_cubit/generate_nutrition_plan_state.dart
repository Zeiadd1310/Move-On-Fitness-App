part of 'generate_nutrition_plan_cubit.dart';

sealed class GenerateNutritionPlanState extends Equatable {
  const GenerateNutritionPlanState();

  @override
  List<Object?> get props => [];
}

final class GenerateNutritionPlanInitial extends GenerateNutritionPlanState {
  const GenerateNutritionPlanInitial();
}

final class GenerateNutritionPlanLoading extends GenerateNutritionPlanState {
  const GenerateNutritionPlanLoading();
}

final class GenerateNutritionPlanSuccess extends GenerateNutritionPlanState {
  final MealsModel mealsModel;

  const GenerateNutritionPlanSuccess(this.mealsModel);

  @override
  List<Object?> get props => [mealsModel];
}

final class GenerateNutritionPlanFailure extends GenerateNutritionPlanState {
  final String errorMessage;

  const GenerateNutritionPlanFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
