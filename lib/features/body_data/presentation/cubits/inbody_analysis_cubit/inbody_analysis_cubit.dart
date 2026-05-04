import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_on/features/body_data/data/models/inbody_analysis_model.dart';
import 'package:move_on/features/body_data/data/repos/body_data_repo.dart';

part 'inbody_analysis_state.dart';

class InbodyAnalysisCubit extends Cubit<InbodyAnalysisState> {
  InbodyAnalysisCubit(this._bodyDataRepo) : super(InbodyAnalysisInitial());

  final BodyDataRepo _bodyDataRepo;

  Future<void> analyzeImage({required String imagePath}) async {
    emit(InbodyAnalysisLoading());
    final result = await _bodyDataRepo.analyzeInbody(imagePath: imagePath);
    result.fold((failure) {
      log('❌ INBODY ANALYZE ERROR: ${failure.errMessage}');
      emit(InbodyAnalysisFailure(failure.errMessage));
    }, (analysis) => emit(InbodyAnalysisSuccess(analysis)));
  }

  void reset() => emit(InbodyAnalysisInitial());
}
