import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:move_on/features/information/data/models/workout_plan_model.dart';

class LocalStorageService {
  static const _isFirstTimeKey = 'is_first_time';
  static const _isSignedInKey = 'is_signed_in';
  static const _tokenKey = 'auth_token';
  // Legacy key used by older auth code paths. Keep for migration.
  static const _legacyTokenKey = 'token';
  static const _isBodyDataCompletedKey = 'is_body_data_completed';
  static const _cachedWorkoutPlanJsonKey = 'cached_workout_plan_json';
  static const _cachedUserProfileJsonKey = 'cached_user_profile_json';
  static const _pendingProfileNameKey = 'pending_profile_name';
  static const _pendingProfileEmailKey = 'pending_profile_email';
  static const _pendingProfileWeightKey = 'pending_profile_weight';
  static const _pendingProfileHeightKey = 'pending_profile_height';
  static const _pendingProfileGenderKey = 'pending_profile_gender';
  static const _workoutHistoryKey = 'workout_history';

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
      log('Error setting signed in status: $e');
    }
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(_tokenKey);
    // Backward compatibility: older versions stored token under `_legacyTokenKey`.
    // If present, migrate it into the canonical key.
    if ((token == null || token.isEmpty)) {
      final legacy = prefs.getString(_legacyTokenKey);
      if (legacy != null && legacy.trim().isNotEmpty) {
        token = legacy.trim();
        await prefs.setString(_tokenKey, token);
        await prefs.remove(_legacyTokenKey);
      }
    }
    if (kDebugMode) {
      final masked = (token == null || token.length < 16)
          ? token
          : '${token.substring(0, 8)}...${token.substring(token.length - 8)}';
      log('🗝️ KEY: $_tokenKey | TOKEN: $masked');
    }
    return token;
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_legacyTokenKey);
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
      log('Error setting body data completed status: $e');
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
      log('Error saving workout plan: $e');
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
      log('Error loading workout plan: $e');
      return null;
    }
  }

  Future<void> clearWorkoutPlan() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_cachedWorkoutPlanJsonKey);
    } catch (e) {
      log('Error clearing workout plan: $e');
    }
  }

  Future<void> saveCachedUserProfile(Map<String, dynamic> profile) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_cachedUserProfileJsonKey, jsonEncode(profile));
    } catch (e) {
      log('Error saving cached user profile: $e');
    }
  }

  Future<Map<String, dynamic>?> loadCachedUserProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_cachedUserProfileJsonKey);
      if (raw == null || raw.isEmpty) return null;
      final decoded = jsonDecode(raw);
      if (decoded is Map<String, dynamic>) return decoded;
      return null;
    } catch (e) {
      log('Error loading cached user profile: $e');
      return null;
    }
  }

  Future<void> clearCachedUserProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_cachedUserProfileJsonKey);
    } catch (e) {
      log('Error clearing cached user profile: $e');
    }
  }

  Future<void> savePendingProfileData({
    String? fullName,
    String? email,
    String? weight,
    String? height,
    String? gender,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    if (fullName != null) {
      await prefs.setString(_pendingProfileNameKey, fullName);
    }
    if (email != null) {
      await prefs.setString(_pendingProfileEmailKey, email);
    }
    if (weight != null) {
      await prefs.setString(_pendingProfileWeightKey, weight);
    }
    if (height != null) {
      await prefs.setString(_pendingProfileHeightKey, height);
    }
    if (gender != null) {
      await prefs.setString(_pendingProfileGenderKey, gender);
    }
  }

  Future<Map<String, String>> getPendingProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'fullName': prefs.getString(_pendingProfileNameKey) ?? '',
      'email': prefs.getString(_pendingProfileEmailKey) ?? '',
      'weight': prefs.getString(_pendingProfileWeightKey) ?? '',
      'height': prefs.getString(_pendingProfileHeightKey) ?? '',
      'gender': prefs.getString(_pendingProfileGenderKey) ?? '',
    };
  }

  Future<void> clearPendingProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_pendingProfileNameKey);
    await prefs.remove(_pendingProfileEmailKey);
    await prefs.remove(_pendingProfileWeightKey);
    await prefs.remove(_pendingProfileHeightKey);
    await prefs.remove(_pendingProfileGenderKey);
  }

  /// Save workout history with dates for calendar integration
  Future<void> saveWorkoutHistory(List<Map<String, dynamic>> workouts) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final encoded = jsonEncode(workouts);
      await prefs.setString(_workoutHistoryKey, encoded);
    } catch (e) {
      log('Error saving workout history: $e');
    }
  }

  /// Load workout history for calendar display
  Future<List<Map<String, dynamic>>> loadWorkoutHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_workoutHistoryKey);
      if (raw == null || raw.isEmpty) return [];
      final decoded = jsonDecode(raw);
      if (decoded is List) {
        return decoded.cast<Map<String, dynamic>>();
      }
      return [];
    } catch (e) {
      log('Error loading workout history: $e');
      return [];
    }
  }

  /// Add a single workout entry to history
  Future<void> addWorkoutEntry(Map<String, dynamic> workout) async {
    final history = await loadWorkoutHistory();
    history.insert(0, workout);
    // Keep only last 100 entries
    if (history.length > 100) {
      history.removeRange(100, history.length);
    }
    await saveWorkoutHistory(history);
  }
}
