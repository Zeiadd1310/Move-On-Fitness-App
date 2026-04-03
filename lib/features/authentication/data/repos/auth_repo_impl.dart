import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:move_on/core/errors/failures.dart';
import 'package:move_on/core/utils/functions/api_service.dart';
import 'package:move_on/features/authentication/data/models/forgot_password_model.dart';
import 'package:move_on/features/authentication/data/models/logout_model.dart';
import 'package:move_on/features/authentication/data/models/reset_password_model.dart';
import 'package:move_on/features/authentication/data/models/signin_model.dart';
import 'package:move_on/features/authentication/data/models/signup_model.dart';
import 'package:move_on/features/authentication/data/repos/auth_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepoImpl implements AuthRepo {
  final ApiService apiService;

  AuthRepoImpl(this.apiService);

  @override
  Future<Either<Failure, SigninModel>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final data = await apiService.post(
        endPoint: 'Account/login',
        body: {'email': email, 'password': password},
      );
      final model = SigninModel.fromJson(data);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', model.token ?? '');
      return Right(model);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, SignupModel>> signUp({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final data = await apiService.post(
        endPoint: 'Account/register',
        body: {
          'name': name,
          'email': email,
          'password': password,
          'confirmPassword': confirmPassword,
        },
      );
      final model = SignupModel.fromJson(data);
      print('✅ SIGNUP TOKEN: ${model.token}');
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', model.token);
      print('✅ TOKEN SAVED');
      return Right(model);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, ForgotPasswordModel>> forgotPassword({
    required String email,
  }) async {
    try {
      final data = await apiService.post(
        endPoint: 'Account/forgotpassword',
        body: {'email': email},
      );
      return Right(ForgotPasswordModel.fromJson(data));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, ResetPasswordModel>> resetPassword({
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final data = await apiService.post(
        endPoint: 'Account/resetpassword',
        body: {'newPassword': newPassword, 'confirmPassword': confirmPassword},
      );
      return Right(ResetPasswordModel.fromJson(data));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, LogoutModel>> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      final data = await apiService.post(endPoint: 'Account/logout', body: {});
      return Right(LogoutModel.fromJson(data));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }
}
