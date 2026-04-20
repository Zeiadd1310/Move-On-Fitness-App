import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:move_on/features/information/data/models/workout_plan_model.dart';

class LocalStorageService {
  static const _isFirstTimeKey = 'is_first_time';
  static const _isSignedInKey = 'is_signed_in';
  static const _tokenKey = 'auth_token';
  static const _isBodyDataCompletedKey = 'is_body_data_completed';
  static const _cachedWorkoutPlanJsonKey = 'cached_workout_plan_json';

  Future<bool> isFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isFirstTimeKey) ?? true;
  }

  Future<void> setNotFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isFirstTimeKey, false);
  }

  Future<bool> isSignedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isSignedInKey) ?? false;
  }

  Future<void> setSignedIn(bool value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_isSignedInKey, value);
    } catch (e) {
      debugPrint('Error setting signed in status: $e');
    }
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);
    if (kDebugMode) {
      final masked = (token == null || token.length < 16)
          ? token
          : '${token.substring(0, 8)}...${token.substring(token.length - 8)}';
      debugPrint('🗝️ KEY: $_tokenKey | TOKEN: $masked');
    }
    return token;
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  Future<bool> isBodyDataCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isBodyDataCompletedKey) ?? false;
  }

  Future<void> setBodyDataCompleted(bool value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_isBodyDataCompletedKey, value);
    } catch (e) {
      debugPrint('Error setting body data completed status: $e');
    }
  }

  /// Persists the last generated workout plan so screens opened without route
  /// `extra` (e.g. Home → Workout) can still show the user's plan.
  Future<void> saveWorkoutPlan(WorkoutPlan plan) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final encoded = jsonEncode(plan.toJson());
      await prefs.setString(_cachedWorkoutPlanJsonKey, encoded);
    } catch (e) {
      debugPrint('Error saving workout plan: $e');
    }
  }

  Future<WorkoutPlan?> loadWorkoutPlan() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_cachedWorkoutPlanJsonKey);
      if (raw == null || raw.isEmpty) return null;
      final map = jsonDecode(raw);
      if (map is! Map<String, dynamic>) return null;
      return WorkoutPlan.fromJson(map);
    } catch (e) {
      debugPrint('Error loading workout plan: $e');
      return null;
    }
  }

  Future<void> clearWorkoutPlan() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_cachedWorkoutPlanJsonKey);
    } catch (e) {
      debugPrint('Error clearing workout plan: $e');
    }
  }
}
