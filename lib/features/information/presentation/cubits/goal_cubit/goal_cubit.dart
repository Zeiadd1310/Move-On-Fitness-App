import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'goal_state.dart';

class GoalCubit extends Cubit<GoalState> {
  GoalCubit() : super(const GoalInitial());

  void selectGoal(String goal) {
    emit(GoalSelected(goal));
  }

  String? get selectedGoal => state.selectedGoal;
}
