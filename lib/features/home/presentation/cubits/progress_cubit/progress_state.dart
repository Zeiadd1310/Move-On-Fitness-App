import 'package:equatable/equatable.dart';
import '../../../data/models/progress_entry_model.dart';
import '../../../data/models/progress_change_model.dart';
import '../../../data/models/progress_analysis_model.dart';
import '../../../data/models/bmi_model.dart';

abstract class ProgressState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProgressInitial extends ProgressState {}

class ProgressLoading extends ProgressState {}

class ProgressLoaded extends ProgressState {
  final ProgressEntryModel? latest;
  final List<ProgressEntryModel> history;
  final List<ProgressEntryModel> chartData;
  final ProgressChangeModel? change;
  final ProgressAnalysisModel? analysis;

  ProgressLoaded({
    this.latest,
    required this.history,
    required this.chartData,
    this.change,
    this.analysis,
  });

  @override
  List<Object?> get props => [latest, history, chartData, change, analysis];
}

class ProgressLogSuccess extends ProgressState {}

class ProgressBmiLoaded extends ProgressState {
  final BmiModel bmi;
  ProgressBmiLoaded(this.bmi);

  @override
  List<Object?> get props => [bmi];
}

class ProgressError extends ProgressState {
  final String message;
  ProgressError(this.message);

  @override
  List<Object?> get props => [message];
}
