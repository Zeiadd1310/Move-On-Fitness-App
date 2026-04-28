import 'package:dartz/dartz.dart';
import 'package:move_on/core/errors/failures.dart';
import '../models/progress_entry_model.dart';
import '../models/progress_change_model.dart';
import '../models/bmi_model.dart';
import '../models/progress_analysis_model.dart';
import '../models/log_progress_request.dart';

abstract class ProgressRepo {
  Future<Either<Failure, String>> logProgress(
    LogProgressRequest request, {
    String? token,
  });
  Future<Either<Failure, ProgressEntryModel>> getLatest({String? token});
  Future<Either<Failure, List<ProgressEntryModel>>> getHistory({String? token});
  Future<Either<Failure, ProgressChangeModel>> getChange({String? token});
  Future<Either<Failure, List<ProgressEntryModel>>> getChart({String? token});
  Future<Either<Failure, BmiModel>> calculateBmi(
    LogProgressRequest request, {
    String? token,
  });
  Future<Either<Failure, ProgressAnalysisModel>> getAnalysis({String? token});
}
