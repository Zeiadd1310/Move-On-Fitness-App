import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'week_plan.dart';

class MealsModel extends Equatable {
  final int? dailyCalories;
  final int? protein;
  final List<WeekPlan>? weekPlan;

  const MealsModel({this.dailyCalories, this.protein, this.weekPlan});

  static int? _asInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }

  static List<dynamic>? _asList(dynamic value) {
    if (value is List) return value;
    if (value is String) {
      try {
        final parsed = _tryParseJson(value);
        if (parsed is List) return parsed;
      } catch (_) {}
    }
    return null;
  }

  static dynamic _tryParseJson(String source) {
    return const JsonDecoder().convert(source);
  }

  factory MealsModel.fromJson(Map<String, dynamic> json) => MealsModel(
    dailyCalories: _asInt(json['daily_calories'] ?? json['dailyCalories']),
    protein: _asInt(json['protein']),
    weekPlan: (_asList(json['week_plan']) ?? _asList(json['weekPlan']))
        ?.map((e) => WeekPlan.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'daily_calories': dailyCalories,
    'protein': protein,
    'week_plan': weekPlan?.map((e) => e.toJson()).toList(),
  };

  @override
  List<Object?> get props => [dailyCalories, protein, weekPlan];
}
