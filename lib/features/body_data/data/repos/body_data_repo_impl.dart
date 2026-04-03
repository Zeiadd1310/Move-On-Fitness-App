import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:move_on/core/errors/failures.dart';
import 'package:move_on/core/services/local_storage_service.dart';
import 'package:move_on/core/utils/functions/api_service.dart';
import 'package:move_on/features/body_data/data/models/manual_assessment_request_model.dart';
import 'package:move_on/features/body_data/data/models/manual_assessment_response_model.dart';
import 'package:move_on/features/body_data/data/repos/body_data_repo.dart';

class BodyDataRepoImpl implements BodyDataRepo {
  final ApiService apiService;
  final LocalStorageService localStorageService;

  BodyDataRepoImpl(this.apiService, this.localStorageService);

  @override
  Future<Either<Failure, ManualAssessmentResponseModel>>
  submitManualAssessment({
    required ManualAssessmentRequestModel request,
  }) async {
    try {
      final token = await localStorageService.getToken();

      // OpenAPI: request body IS `AssessmentDto` at the JSON root (not `{ "model": ... }`).
      // A wrapper makes `[FromBody] AssessmentDto` bind empty → DB gets zeros/nulls.
      final payload = request.toAssessmentApiJson();
      log('📤 MANUAL PAYLOAD: $payload');
      final data = await apiService.post(
        endPoint: 'Assessment/manual',
        body: payload,
        token: token,
      );
      final parsed = ManualAssessmentResponseModel.fromJson(data);
      log('✅ MANUAL ASSESSMENT RESPONSE: ${parsed.toJson()}');
      return Right(parsed);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }
}
