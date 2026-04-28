import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_on/core/errors/failures.dart';
import '../../../data/models/log_progress_request.dart';
import '../../../data/models/progress_analysis_model.dart';
import '../../../data/models/progress_change_model.dart';
import '../../../data/models/progress_entry_model.dart';
import '../../../data/repos/progress_repo.dart';
import 'progress_state.dart';

class ProgressCubit extends Cubit<ProgressState> {
  final ProgressRepo repo;

  ProgressCubit(this.repo) : super(ProgressInitial());

  /// True only for real connectivity failures (no internet, timeouts).
  /// HTTP response errors (4xx, 5xx) mean "no data" for progress endpoints.
  bool _isConnectivityError(Failure f) {
    final msg = f.errMessage.toLowerCase();
    return msg.contains('timeout') ||
        msg.contains('no internet') ||
        msg.contains('connection error') ||
        msg.contains('ssl certificate');
  }

  Future<void> loadProgress(String token) async {
    emit(ProgressLoading());

    final latestResult = await repo.getLatest(token: token);
    final historyResult = await repo.getHistory(token: token);
    final chartResult = await repo.getChart(token: token);
    final changeResult = await repo.getChange(token: token);
    final analysisResult = await repo.getAnalysis(token: token);

    // Only fail hard on true connectivity errors — HTTP errors = no data yet.
    for (final result in [
      latestResult,
      historyResult,
      chartResult,
      changeResult,
      analysisResult,
    ]) {
      final failure = result.fold<Failure?>((f) => f, (_) => null);
      if (failure != null && _isConnectivityError(failure)) {
        log('❌ PROGRESS CONNECTIVITY ERROR: ${failure.errMessage}');
        emit(ProgressError(failure.errMessage));
        return;
      }
    }

    // Resolve values — any HTTP error → null/empty, success → actual value.
    final latest = latestResult.fold<ProgressEntryModel?>((f) => null, (v) => v);
    final change = changeResult.fold<ProgressChangeModel?>((f) => null, (v) => v);
    final analysis = analysisResult.fold<ProgressAnalysisModel?>((f) => null, (v) => v);
    final history = historyResult.fold<List<ProgressEntryModel>>((f) => [], (v) => v);
    final chartData = chartResult.fold<List<ProgressEntryModel>>((f) => [], (v) => v);

    log('✅ PROGRESS LOADED — latest: ${latest != null}, '
        'history: ${history.length}, chart: ${chartData.length}');

    emit(
      ProgressLoaded(
        latest: latest,
        history: history,
        chartData: chartData,
        change: change,
        analysis: analysis,
      ),
    );
  }

  Future<void> logProgress(LogProgressRequest request, String token) async {
    final result = await repo.logProgress(request, token: token);
    result.fold(
      (failure) => emit(ProgressError(failure.errMessage)),
      (_) => emit(ProgressLogSuccess()),
    );
  }

  Future<void> calculateBmi(LogProgressRequest request, String token) async {
    final result = await repo.calculateBmi(request, token: token);
    result.fold(
      (failure) => emit(ProgressError(failure.errMessage)),
      (bmi) => emit(ProgressBmiLoaded(bmi)),
    );
  }
}
