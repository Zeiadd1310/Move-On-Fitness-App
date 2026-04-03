import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_on/features/body_data/data/models/manual_assessment_request_model.dart';
import 'package:move_on/features/body_data/data/repos/body_data_repo.dart';

part 'manual_assessment_state.dart';

class ManualAssessmentCubit extends Cubit<ManualAssessmentState> {
  ManualAssessmentCubit(this.bodyDataRepo) : super(ManualAssessmentInitial());
  final BodyDataRepo bodyDataRepo;

  Future<void> submitManualAssessment({
    required ManualAssessmentRequestModel request,
  }) async {
    emit(ManualAssessmentLoading());
    final result = await bodyDataRepo.submitManualAssessment(request: request);
    result.fold((failure) {
      log('❌ ERROR: ${failure.errMessage}');

      emit(ManualAssessmentFailure(failure.errMessage));
    }, (response) => emit(ManualAssessmentSuccess(response.assessmentId)));
  }
}
