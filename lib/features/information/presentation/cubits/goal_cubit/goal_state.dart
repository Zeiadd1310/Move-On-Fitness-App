part of 'goal_cubit.dart';

sealed class GoalState extends Equatable {
  final String? selectedGoal;
  const GoalState({this.selectedGoal});

  @override
  List<Object?> get props => [selectedGoal];
}

final class GoalInitial extends GoalState {
  const GoalInitial();
}

final class GoalSelected extends GoalState {
  const GoalSelected(String goal) : super(selectedGoal: goal);
}
