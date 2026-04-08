import 'package:dartz/dartz.dart';
import 'package:move_on/core/errors/failures.dart';
import 'package:move_on/features/body_data/data/models/manual_assessment_request_model.dart';
import 'package:move_on/features/body_data/data/models/manual_assessment_response_model.dart';

abstract class BodyDataRepo {
  Future<Either<Failure, ManualAssessmentResponseModel>>
  submitManualAssessment({required ManualAssessmentRequestModel request});
}
