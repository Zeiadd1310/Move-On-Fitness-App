import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:move_on/core/errors/failures.dart';
import 'package:move_on/core/services/local_storage_service.dart';
import 'package:move_on/core/utils/functions/api_service.dart';
import 'package:move_on/features/nutrition/data/models/meals_model/meals_model.dart';
import 'package:move_on/features/nutrition/data/repos/nutrition_repo.dart';

class NutritionRepoImpl implements NutritionRepo {
  final ApiService apiService;
  final LocalStorageService localStorageService;

  NutritionRepoImpl(this.apiService, this.localStorageService);

  @override
  Future<Either<Failure, MealsModel>> generateNutritionPlan() async {
    try {
      final token = await localStorageService.getToken();

      if (token == null || token.trim().isEmpty) {
        log('❌ GENERATE NUTRITION: No auth token found');
        return Left(ServerFailure('Not authenticated. Please log in again.'));
      }

      log('🍽️ GENERATE NUTRITION: Calling endpoint...');
      final data = await apiService.post(
        endPoint: 'Meal/GenerateNutritionPlan',
        body: const {},
        token: token,
        receiveTimeout: const Duration(minutes: 3), // AI generation takes time
      );

      dynamic rawPlan =
          data['nutritionPlan'] ?? data['plan'] ?? data['data'] ?? data;
      if (rawPlan is! Map<String, dynamic>) {
        return Left(ServerFailure('Invalid nutrition plan response format'));
      }

      final mealsPlan = MealsModel.fromJson(rawPlan);
      log('✅ NUTRITION PLAN GENERATED');
      return Right(mealsPlan);
    } on DioException catch (e) {
      log(
        '❌ GENERATE NUTRITION DIO ERROR'
        '\n  type    : ${e.type}'
        '\n  message : ${e.message}'
        '\n  uri     : ${e.requestOptions.uri}'
        '\n  status  : ${e.response?.statusCode}'
        '\n  data    : ${e.response?.data}',
      );
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      log('❌ GENERATE NUTRITION UNKNOWN ERROR: $e');
      return Left(ServerFailure(e.toString()));
    }
  }
}
