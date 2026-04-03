import 'package:equatable/equatable.dart';

class ManualAssessmentResponseModel extends Equatable {
  final String? message;
  final int? assessmentId;

  const ManualAssessmentResponseModel({this.message, this.assessmentId});

  factory ManualAssessmentResponseModel.fromJson(Map<String, dynamic> json) =>
      ManualAssessmentResponseModel(
        message: json['message'] as String?,
        assessmentId: json['assessmentId'] as int?,
      );

  Map<String, dynamic> toJson() => {
    'message': message,
    'assessmentId': assessmentId,
  };

  @override
  List<Object?> get props => [message, assessmentId];
}
