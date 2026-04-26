import 'package:equatable/equatable.dart';

import 'breakfast.dart';
import 'dinner.dart';
import 'lunch.dart';
import 'snacks.dart';

class WeekPlan extends Equatable {
  final String? day;
  final Breakfast? breakfast;
  final Lunch? lunch;
  final Dinner? dinner;
  final Snacks? snacks;

  const WeekPlan({
    this.day,
    this.breakfast,
    this.lunch,
    this.dinner,
    this.snacks,
  });

  factory WeekPlan.fromJson(Map<String, dynamic> json) => WeekPlan(
    day: json['day'] as String?,
    breakfast: json['breakfast'] == null
        ? null
        : Breakfast.fromJson(json['breakfast'] as Map<String, dynamic>),
    lunch: json['lunch'] == null
        ? null
        : Lunch.fromJson(json['lunch'] as Map<String, dynamic>),
    dinner: json['dinner'] == null
        ? null
        : Dinner.fromJson(json['dinner'] as Map<String, dynamic>),
    snacks: json['snacks'] == null
        ? null
        : Snacks.fromJson(json['snacks'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'day': day,
    'breakfast': breakfast?.toJson(),
    'lunch': lunch?.toJson(),
    'dinner': dinner?.toJson(),
    'snacks': snacks?.toJson(),
  };

  @override
  List<Object?> get props => [day, breakfast, lunch, dinner, snacks];
}
