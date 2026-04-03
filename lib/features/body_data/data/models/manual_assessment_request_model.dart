import 'package:equatable/equatable.dart';

class ManualAssessmentRequestModel extends Equatable {
  final int age;
  final String gender;
  final double weight;
  final double height;
  final double musclePercentage;
  final double fatPercentage;
  final double waterPercentage;
  final double bmr;

  const ManualAssessmentRequestModel({
    required this.age,
    required this.gender,
    required this.weight,
    required this.height,
    required this.musclePercentage,
    required this.fatPercentage,
    required this.waterPercentage,
    required this.bmr,
  });

  Map<String, dynamic> toJson() {
    return {
      'age': age,
      'gender': gender,
      'weight': weight,
      'height': height,
      'musclePercentage': musclePercentage,
      'fatPercentage': fatPercentage,
      'waterPercentage': waterPercentage,
      'bmr': bmr,
    };
  }

  /// Shape must match OpenAPI `AssessmentDto` for `POST /api/Assessment/manual`
  /// (only these keys; `bmr` is int32 on the API).
  Map<String, dynamic> toAssessmentApiJson() {
    return {
      'age': age,
      'gender': gender,
      'weight': weight,
      'height': height,
      'musclePercentage': musclePercentage,
      'fatPercentage': fatPercentage,
      'waterPercentage': waterPercentage,
      'bmr': bmr.round(),
    };
  }

  @override
  List<Object?> get props => [
    age,
    gender,
    weight,
    height,
    musclePercentage,
    fatPercentage,
    waterPercentage,
    bmr,
  ];
}
