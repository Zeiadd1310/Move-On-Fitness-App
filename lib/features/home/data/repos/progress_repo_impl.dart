import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:move_on/core/errors/failures.dart';
import 'package:move_on/core/utils/functions/api_service.dart';
import '../models/progress_entry_model.dart';
import '../models/progress_change_model.dart';
import '../models/bmi_model.dart';
import '../models/progress_analysis_model.dart';
import '../models/log_progress_request.dart';
import 'progress_repo.dart';

class ProgressRepoImpl implements ProgressRepo {
  final ApiService apiService;
  ProgressRepoImpl(this.apiService);

  @override
  Future<Either<Failure, String>> logProgress(
    LogProgressRequest request, {
    String? token,
  }) async {
    try {
      final response = await apiService.post(
        endPoint: 'progress',
        body: request.toJson(),
        token: token,
      );
      return Right(response['message'] as String);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, ProgressEntryModel>> getLatest({String? token}) async {
    try {
      final response = await apiService.get(
        endPoint: 'progress/latest',
        token: token,
      );
      return Right(ProgressEntryModel.fromJson(response));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, List<ProgressEntryModel>>> getHistory({
    String? token,
  }) async {
    try {
      final response = await apiService.getList(
        endPoint: 'progress/history',
        token: token,
      );
      return Right(
        response
            .map((e) => ProgressEntryModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, ProgressChangeModel>> getChange({
    String? token,
  }) async {
    try {
      final response = await apiService.get(
        endPoint: 'progress/change',
        token: token,
      );
      return Right(ProgressChangeModel.fromJson(response));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, List<ProgressEntryModel>>> getChart({
    String? token,
  }) async {
    try {
      final response = await apiService.getList(
        endPoint: 'progress/chart',
        token: token,
      );
      return Right(
        response
            .map((e) => ProgressEntryModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, BmiModel>> calculateBmi(
    LogProgressRequest request, {
    String? token,
  }) async {
    try {
      final response = await apiService.post(
        endPoint: 'progress/calculate-BMI',
        body: request.toJson(),
        token: token,
      );
      return Right(BmiModel.fromJson(response));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, ProgressAnalysisModel>> getAnalysis({
    String? token,
  }) async {
    try {
      final response = await apiService.get(
        endPoint: 'progress/progress-analysis',
        token: token,
      );
      return Right(ProgressAnalysisModel.fromJson(response));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }
}
