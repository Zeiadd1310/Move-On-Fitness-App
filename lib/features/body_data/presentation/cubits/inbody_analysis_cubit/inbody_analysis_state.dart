part of 'inbody_analysis_cubit.dart';

sealed class InbodyAnalysisState extends Equatable {
  const InbodyAnalysisState();

  @override
  List<Object?> get props => [];
}

final class InbodyAnalysisInitial extends InbodyAnalysisState {}

final class InbodyAnalysisLoading extends InbodyAnalysisState {}

final class InbodyAnalysisSuccess extends InbodyAnalysisState {
  const InbodyAnalysisSuccess(this.analysis);

  final InbodyAnalysisModel analysis;

  @override
  List<Object?> get props => [analysis];
}

final class InbodyAnalysisFailure extends InbodyAnalysisState {
  const InbodyAnalysisFailure(this.error);

  final String error;

  @override
  List<Object?> get props => [error];
}
