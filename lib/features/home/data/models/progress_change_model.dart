import 'package:equatable/equatable.dart';

class ProgressChangeModel extends Equatable {
  final double? weightChange;
  final double? fatChange;
  final double? muscleChange;
  final double? bmrChange;
  final double? bmiChange;

  const ProgressChangeModel({
    this.weightChange,
    this.fatChange,
    this.muscleChange,
    this.bmrChange,
    this.bmiChange,
  });

  static double? _asDouble(dynamic v) {
    if (v is double) return v;
    if (v is int) return v.toDouble();
    if (v is String) return double.tryParse(v);
    return null;
  }

  factory ProgressChangeModel.fromJson(Map<String, dynamic> json) =>
      ProgressChangeModel(
        weightChange: _asDouble(json['weightChange']),
        fatChange: _asDouble(json['fatChange']),
        muscleChange: _asDouble(json['muscleChange']),
        bmrChange: _asDouble(json['bmrChange']),
        bmiChange: _asDouble(json['bmiChange']),
      );

  @override
  List<Object?> get props => [
    weightChange,
    fatChange,
    muscleChange,
    bmrChange,
    bmiChange,
  ];
}
