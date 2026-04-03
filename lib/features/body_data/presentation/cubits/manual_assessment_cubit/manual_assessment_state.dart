part of 'manual_assessment_cubit.dart';

sealed class ManualAssessmentState extends Equatable {
  const ManualAssessmentState();

  @override
  List<Object> get props => [];
}

final class ManualAssessmentInitial extends ManualAssessmentState {}

final class ManualAssessmentLoading extends ManualAssessmentState {}

final class ManualAssessmentSuccess extends ManualAssessmentState {
  final int? assessmentId;

  const ManualAssessmentSuccess(this.assessmentId);

  @override
  List<Object> get props => [assessmentId ?? -1];
}

final class ManualAssessmentFailure extends ManualAssessmentState {
  final String error;
  const ManualAssessmentFailure(this.error);
}
