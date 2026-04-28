import 'package:equatable/equatable.dart';

class ProgressEntryModel extends Equatable {
  final String? date;
  final double? weight;
  final double? fatPercentage;
  final double? musclePercentage;
  final double? bmi;
  final double? bmr;
  final double? fat;
  final double? muscle;

  const ProgressEntryModel({
    this.date,
    this.weight,
    this.fatPercentage,
    this.musclePercentage,
    this.bmi,
    this.bmr,
    this.fat,
    this.muscle,
  });

  static double? _asDouble(dynamic v) {
    if (v is double) return v;
    if (v is int) return v.toDouble();
    if (v is String) return double.tryParse(v);
    return null;
  }

  factory ProgressEntryModel.fromJson(Map<String, dynamic> json) =>
      ProgressEntryModel(
        date: json['date'] as String?,
        weight: _asDouble(json['weight']),
        fatPercentage: _asDouble(json['fatPercentage']),
        musclePercentage: _asDouble(json['musclePercentage']),
        bmi: _asDouble(json['bmi']),
        bmr: _asDouble(json['bmr']),
        fat: _asDouble(json['fat']),
        muscle: _asDouble(json['muscle']),
      );

  Map<String, dynamic> toJson() => {
    'date': date,
    'weight': weight,
    'fatPercentage': fatPercentage,
    'musclePercentage': musclePercentage,
    'bmi': bmi,
    'bmr': bmr,
  };

  @override
  List<Object?> get props => [
    date,
    weight,
    fatPercentage,
    musclePercentage,
    bmi,
    bmr,
    fat,
    muscle,
  ];
}
