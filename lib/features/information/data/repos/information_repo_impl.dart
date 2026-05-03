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

  bool _looksLikeExistingWorkoutPlanMessage(String message) {
    final lower = message.toLowerCase();
    if (!lower.contains('plan')) return false;
    return lower.contains('update') ||
        lower.contains('already') ||
        lower.contains('exist') ||
        lower.contains('duplicate');
  }

  Future<WorkoutPlan?> _parseAndPersistPlan(Map<String, dynamic> data) async {
    dynamic rawPlan =
        data['workoutPlan'] ?? data['plan'] ?? data['data'] ?? data;

    if (rawPlan is Map<String, dynamic> && rawPlan['weeks'] == null) {
      final nested =
          rawPlan['result'] ?? rawPlan['payload'] ?? rawPlan['workout'];
      if (nested is Map<String, dynamic>) {
        rawPlan = nested;
      }
    }

    if (rawPlan is! Map<String, dynamic>) return null;

    final plan = WorkoutPlan.fromJson(rawPlan);
    await localStorageService.saveWorkoutPlan(plan);
    return plan;
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

      late Map<String, dynamic> envelope;
      try {
        envelope = await apiService.post(
          endPoint: 'Workout/GenerateWorkoutPlan',
          body: payload,
          token: token,
        );
        log('✅ WORKOUT PLAN GENERATED');
      } on DioException catch (eGen) {
        log(
          '❌ GENERATE WORKOUT DIO ERROR | status=${eGen.response?.statusCode} | data=${eGen.response?.data}',
        );
        final genFailure = ServerFailure.fromDioError(eGen);
        if (!_looksLikeExistingWorkoutPlanMessage(genFailure.errMessage)) {
          return Left(genFailure);
        }

        log('🔄 Falling back to Workout/UpdateWorkoutPlan');
        try {
          envelope = await apiService.put(
            endPoint: 'Workout/UpdateWorkoutPlan',
            body: payload,
            token: token,
          );
          log('✅ WORKOUT PLAN UPDATED');
        } on DioException catch (eUpd) {
          log(
            '❌ UPDATE WORKOUT DIO ERROR | status=${eUpd.response?.statusCode} | data=${eUpd.response?.data}',
          );
          return Left(ServerFailure.fromDioError(eUpd));
        }
      }

      final persisted = await _parseAndPersistPlan(envelope);
      if (persisted == null) {
        return Left(ServerFailure('Invalid workout plan response format'));
      }
      return Right(persisted);
    } catch (e) {
      log('❌ GENERATE WORKOUT UNKNOWN ERROR: $e');
      return Left(ServerFailure(e.toString()));
    }
  }
}
