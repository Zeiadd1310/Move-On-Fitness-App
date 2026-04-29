import 'package:equatable/equatable.dart';
import 'package:move_on/core/services/notification_preferences_service.dart';
import '../../../data/models/reminder_model.dart';

abstract class NotificationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationLoaded extends NotificationState {
  final List<ReminderModel> reminders;
  final NotificationPreferences prefs;
  NotificationLoaded({
    required this.reminders,
    required this.prefs,
  });
  @override
  List<Object?> get props => [reminders, prefs];
}

class NotificationError extends NotificationState {
  final String message;
  NotificationError(this.message);
  @override
  List<Object?> get props => [message];
}
