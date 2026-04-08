part of 'activity_level_cubit.dart';

sealed class ActivityLevelState extends Equatable {
  final String? selectedActivityLevel;
  const ActivityLevelState({this.selectedActivityLevel});

  @override
  List<Object?> get props => [selectedActivityLevel];
}

final class ActivityLevelInitial extends ActivityLevelState {
  const ActivityLevelInitial();
}

final class ActivityLevelSelected extends ActivityLevelState {
  const ActivityLevelSelected(String activityLevel)
    : super(selectedActivityLevel: activityLevel);
}
