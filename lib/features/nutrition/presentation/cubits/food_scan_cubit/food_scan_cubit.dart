import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_on/features/nutrition/data/models/food_analysis_model.dart';
import 'package:move_on/features/nutrition/data/repos/nutrition_repo.dart';

part 'food_scan_state.dart';

class FoodScanCubit extends Cubit<FoodScanState> {
  FoodScanCubit(this._nutritionRepo) : super(const FoodScanInitial());

  final NutritionRepo _nutritionRepo;

  Future<void> analyzeImage({required String imagePath}) async {
    emit(const FoodScanLoading());
    final result = await _nutritionRepo.analyzeFood(imagePath: imagePath);
    result.fold((failure) {
      log('❌ FOOD SCAN ERROR: ${failure.errMessage}');
      emit(FoodScanFailure(failure.errMessage));
    }, (analysis) => emit(FoodScanSuccess(analysis: analysis, imagePath: imagePath)));
  }

  void reset() => emit(const FoodScanInitial());
}

