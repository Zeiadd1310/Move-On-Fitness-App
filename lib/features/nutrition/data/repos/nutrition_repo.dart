import 'package:dartz/dartz.dart';
import 'package:move_on/core/errors/failures.dart';
import 'package:move_on/features/nutrition/data/models/meals_model/meals_model.dart';
import 'package:move_on/features/nutrition/data/models/food_analysis_model.dart';

abstract class NutritionRepo {
  Future<Either<Failure, MealsModel>> generateNutritionPlan();

  Future<Either<Failure, FoodAnalysisModel>> analyzeFood({
    required String imagePath,
  });

  Future<MealsModel?> loadCachedNutritionPlan();
}
