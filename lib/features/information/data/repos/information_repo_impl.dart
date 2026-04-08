import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:move_on/core/errors/failures.dart';
import 'package:move_on/core/services/local_storage_service.dart';
import 'package:move_on/core/utils/functions/api_service.dart';
import 'package:move_on/features/information/data/models/workout_plan_model.dart';
import 'package:move_on/features/information/data/repos/information_repo.dart';

class InformationRepoImpl implements InformationRepo {
  final ApiService apiService;
  final LocalStorageService localStorageService;

  InformationRepoImpl(this.apiService, this.localStorageService);

  String _normalizeGoal(String goal) {
    final value = goal.trim();
    switch (value.toLowerCase()) {
      case 'lose weight':
      case 'lose_weight':
      case 'loseweight':
        return 'LoseWeight';
      case 'gain muscle':
      case 'gain_muscle':
      case 'gainmuscle':
        return 'GainMuscle';
      case 'gain muscles and lose weight':
      case 'gain_muscles_and_lose_weight':
      case 'gainmusclesandloseweight':
      case 'recomposition':
        return 'GainMusclesAndLoseWeight';
      default:
        return value;
    }
  }

  @override
  Future<Either<Failure, WorkoutPlan>> generateWorkoutPlan({
    required int activityLevel,
    required String goal,
    required int availableDays,
  }) async {
    try {
      final token = await localStorageService.getToken();
      final normalizedGoal = _normalizeGoal(goal);
      final payload = {
        'goal': normalizedGoal,
        'availableDays': availableDays,
        'activitylevel': activityLevel,
      };
      log('📤 GENERATE WORKOUT PAYLOAD: $payload');

      final data = await apiService.post(
        endPoint: 'Workout/GenerateWorkoutPlan',
        body: payload,
        token: token,
      );

      // Supports common response shapes:
      // - full plan at root
      // - nested under `workoutPlan` / `plan` / `data`
      final dynamic rawPlan =
          data['workoutPlan'] ?? data['plan'] ?? data['data'] ?? data;

      if (rawPlan is! Map<String, dynamic>) {
        return Left(ServerFailure('Invalid workout plan response format'));
      }

      final plan = WorkoutPlan.fromJson(rawPlan);
      log('✅ WORKOUT PLAN GENERATED');
      return Right(plan);
    } on DioException catch (e) {
      log(
        '❌ GENERATE WORKOUT DIO ERROR | status=${e.response?.statusCode} | data=${e.response?.data}',
      );
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      log('❌ GENERATE WORKOUT UNKNOWN ERROR: $e');
      return Left(ServerFailure(e.toString()));
    }
  }
}
