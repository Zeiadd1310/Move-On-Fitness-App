import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'days_state.dart';

class DaysCubit extends Cubit<DaysState> {
  DaysCubit() : super(const DaysInitial());

  void selectDays(int days) {
    if (days < 1 || days > 7) return;
    emit(DaysSelected(days));
  }

  int? get selectedDays => state.selectedDays;
}
