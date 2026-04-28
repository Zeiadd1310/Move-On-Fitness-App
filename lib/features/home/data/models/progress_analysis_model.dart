import 'package:equatable/equatable.dart';

class ProgressAnalysisModel extends Equatable {
  final String? weightStatus;
  final String? fatStatus;
  final String? muscleStatus;
  final double? avgWeeklyWeightChange;
  final String? insight;

  const ProgressAnalysisModel({
    this.weightStatus,
    this.fatStatus,
    this.muscleStatus,
    this.avgWeeklyWeightChange,
    this.insight,
  });

  factory ProgressAnalysisModel.fromJson(Map<String, dynamic> json) =>
      ProgressAnalysisModel(
        weightStatus: json['weightStatus'] as String?,
        fatStatus: json['fatStatus'] as String?,
        muscleStatus: json['muscleStatus'] as String?,
        avgWeeklyWeightChange: (json['avgWeeklyWeightChange'] as num?)
            ?.toDouble(),
        insight: json['insight'] as String?,
      );

  @override
  List<Object?> get props => [
    weightStatus,
    fatStatus,
    muscleStatus,
    avgWeeklyWeightChange,
    insight,
  ];
}
