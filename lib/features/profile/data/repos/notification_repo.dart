import 'package:dartz/dartz.dart';
import 'package:move_on/core/errors/failures.dart';
import '../models/reminder_model.dart';

abstract class NotificationRepo {
  Future<Either<Failure, List<ReminderModel>>> getReminders({String? token});
  Future<Either<Failure, void>> registerFcmToken(
    String fcmToken, {
    String? token,
  });
}
