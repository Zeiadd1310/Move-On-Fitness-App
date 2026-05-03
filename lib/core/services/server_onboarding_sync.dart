import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:move_on/core/services/local_storage_service.dart';
import 'package:move_on/core/utils/functions/api_service.dart';
import 'package:move_on/features/information/data/models/workout_plan_model.dart';

/// Reconciles device onboarding flags / cached workout with the deployed API after sign-in,
/// since body-data completion lives in SharedPreferences and can disagree with `moveonapi`.
class ServerOnboardingSync {
  ServerOnboardingSync(this._apiService, this._localStorageService);

  final ApiService _apiService;
  final LocalStorageService _localStorageService;

  Future<void> hydrateFromServer() async {
    try {
      final raw = await _localStorageService.getToken();
      final token = raw?.trim();
      if (token == null || token.isEmpty) return;

      await _hydrateWorkoutPlanIfNeeded(token);

      if (await _localStorageService.isBodyDataCompleted()) return;

      await _markBodyDataCompleteFromLastAssessment(token);
    } catch (e) {
      log('Server onboarding sync skipped: $e');
    }
  }

  Future<void> _hydrateWorkoutPlanIfNeeded(String token) async {
    try {
      final data = await _apiService.get(
        endPoint: 'Workout/GetWorkoutPlan',
        token: token,
      );

      dynamic rawPlan =
          data['workoutPlan'] ?? data['plan'] ?? data['data'] ?? data;

      if (rawPlan is Map<String, dynamic> && rawPlan['weeks'] == null) {
        final nested =
            rawPlan['result'] ?? rawPlan['payload'] ?? rawPlan['workout'];
        if (nested is Map<String, dynamic>) {
          rawPlan = nested;
        }
      }

      if (rawPlan is! Map<String, dynamic>) return;
      if (rawPlan['weeks'] is! List) return;

      final plan = WorkoutPlan.fromJson(rawPlan);
      await _localStorageService.saveWorkoutPlan(plan);
      await _localStorageService.setBodyDataCompleted(true);
      log('✅ Hydrated workout plan from server');
    } on DioException catch (e) {
      final code = e.response?.statusCode;
      if (code == 404) return;
      log('GetWorkoutPlan failed during onboarding sync: $e');
    } catch (e) {
      log('GetWorkoutPlan parse failed during onboarding sync: $e');
    }
  }

  Future<void> _markBodyDataCompleteFromLastAssessment(String token) async {
    try {
      final data = await _apiService.get(
        endPoint: 'Assessment/GetLastAssessment',
        token: token,
      );

      final map = _unwrapToMap(data);
      if (map == null || !_mapLooksLikeManualAssessment(map)) return;

      await _localStorageService.setBodyDataCompleted(true);
      log('✅ Marked body data complete from last assessment on server');
    } on DioException catch (e) {
      final code = e.response?.statusCode;
      if (code == 404) return;
      log('GetLastAssessment failed during onboarding sync: $e');
    } catch (e) {
      log('GetLastAssessment parse failed during onboarding sync: $e');
    }
  }

  static Map<String, dynamic>? _unwrapToMap(Map<String, dynamic> root) {
    final nested =
        root['data'] ?? root['assessment'] ?? root['result'] ?? root['value'];
    if (nested is Map<String, dynamic>) return nested;
    return root;
  }

  static bool _mapLooksLikeManualAssessment(Map<String, dynamic> json) {
    final age = json['age'];
    if (age is num && age > 0) return true;

    final weight = json['weight'];
    final height = json['height'];
    if (weight is num && height is num && weight > 0 && height > 0) {
      return true;
    }
    return false;
  }
}
