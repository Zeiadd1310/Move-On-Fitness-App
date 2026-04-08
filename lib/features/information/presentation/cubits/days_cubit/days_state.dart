part of 'days_cubit.dart';

sealed class DaysState extends Equatable {
  final int? selectedDays;
  const DaysState({this.selectedDays});

  @override
  List<Object?> get props => [selectedDays];
}

final class DaysInitial extends DaysState {
  const DaysInitial();
}

final class DaysSelected extends DaysState {
  const DaysSelected(int days) : super(selectedDays: days);
}
