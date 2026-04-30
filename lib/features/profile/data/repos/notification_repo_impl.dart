import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:move_on/core/errors/failures.dart';
import 'package:move_on/core/utils/functions/api_service.dart';
import '../models/reminder_model.dart';
import 'notification_repo.dart';

class NotificationRepoImpl implements NotificationRepo {
  final ApiService apiService;
  NotificationRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<ReminderModel>>> getReminders({
    String? token,
  }) async {
    try {
      final response = await apiService.getList(
        endPoint: 'notification/reminders',
        token: token,
      );
      return Right(
        response
            .map((e) => ReminderModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, void>> registerFcmToken(
    String fcmToken, {
    String? token,
  }) async {
    try {
      await apiService.post(
        endPoint: 'notification/save-token',
        // Backend expects the FCM device token under `token`.
        // Keep `fcmToken` too for compatibility if the API accepts either.
        body: {'token': fcmToken, 'fcmToken': fcmToken},
        token: token,
      );
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }
}
