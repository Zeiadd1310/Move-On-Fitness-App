import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:move_on/core/errors/failures.dart';
import 'package:move_on/core/services/local_storage_service.dart';
import 'package:move_on/core/utils/functions/api_service.dart';
import 'package:move_on/features/nutrition/data/models/meals_model/meals_model.dart';
import 'package:move_on/features/nutrition/data/models/food_analysis_model.dart';
import 'package:move_on/features/nutrition/data/repos/nutrition_repo.dart';

class NutritionRepoImpl implements NutritionRepo {
  static const _foodAnalyzeUrl =
      'https://food-scan-ocr-production.up.railway.app/analyze-food';

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
      await localStorageService.saveNutritionPlan(mealsPlan);
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

  @override
  Future<Either<Failure, FoodAnalysisModel>> analyzeFood({
    required String imagePath,
  }) async {
    try {
      final dio = Dio(
        BaseOptions(
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 45),
          headers: {'accept': 'application/json'},
        ),
      );
      final fileName = imagePath.split(RegExp(r'[\\/]')).last;
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(imagePath, filename: fileName),
      });
      final response = await dio.post<Map<String, dynamic>>(
        _foodAnalyzeUrl,
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );
      final body = response.data;
      if (body == null || body.isEmpty) {
        return Left(ServerFailure('Empty response from food analyzer'));
      }
      final status = (body['status'] ?? '').toString().toLowerCase();
      if (status.isNotEmpty && status != 'success') {
        final msg = (body['message'] ?? body['detail'] ?? status).toString();
        return Left(ServerFailure(msg));
      }
      final data = body['data'];
      if (data is! Map<String, dynamic>) {
        return Left(ServerFailure('Invalid analyzer response format'));
      }
      return Right(FoodAnalysisModel.fromJson(data));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<MealsModel?> loadCachedNutritionPlan() async {
    return await localStorageService.loadNutritionPlan();
  }
}
