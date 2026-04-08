import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'activity_level_state.dart';

class ActivityLevelCubit extends Cubit<ActivityLevelState> {
  ActivityLevelCubit() : super(const ActivityLevelInitial());

  void selectActivityLevel(String activityLevel) {
    emit(ActivityLevelSelected(activityLevel));
  }

  String? get selectedActivityLevel => state.selectedActivityLevel;
}
