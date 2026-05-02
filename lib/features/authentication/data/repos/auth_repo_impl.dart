import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:move_on/core/errors/failures.dart';
import 'package:move_on/core/services/local_storage_service.dart';
import 'package:move_on/core/utils/functions/api_service.dart';
import 'package:move_on/features/authentication/data/models/change_password_model.dart';
import 'package:move_on/features/authentication/data/models/forgot_password_model.dart';
import 'package:move_on/features/authentication/data/models/logout_model.dart';
import 'package:move_on/features/authentication/data/models/reset_password_model.dart';
import 'package:move_on/features/authentication/data/models/signin_model.dart';
import 'package:move_on/features/authentication/data/models/signup_model.dart';
import 'package:move_on/features/authentication/data/repos/auth_repo.dart';

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
      final token = (model.token ?? '').trim();
      final localStorage = LocalStorageService();
      if (token.isNotEmpty) {
        await localStorage.saveToken(token);
        await localStorage.setSignedIn(true);
      }
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
      final token = model.token.trim();
      final localStorage = LocalStorageService();
      if (token.isNotEmpty) {
        await localStorage.saveToken(token);
        await localStorage.setSignedIn(true);
      }
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
      final localStorage = LocalStorageService();
      final authHeader = await localStorage.getToken();
      final data = await apiService.post(
        endPoint: 'Account/forgotpassword',
        body: {'email': email},
        token: authHeader?.trim().isEmpty == true ? null : authHeader,
      );
      return Right(ForgotPasswordModel.fromJson(data));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, ResetPasswordModel>> resetPassword({
    required String email,
    required String token,
    required String newPassword,
  }) async {
    try {
      final localStorage = LocalStorageService();
      final authHeader = await localStorage.getToken();
      final data = await apiService.post(
        endPoint: 'Account/resetpassword',
        body: {
          'email': email.trim(),
          'token': token.trim(),
          'newPassword': newPassword,
        },
        token: authHeader?.trim().isEmpty == true ? null : authHeader,
      );
      return Right(ResetPasswordModel.fromJson(data));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, ChangePasswordModel>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final localStorage = LocalStorageService();
      final token = await localStorage.getToken();
      final trimmed = token?.trim();
      if (trimmed == null || trimmed.isEmpty) {
        return Left(
          ServerFailure('Not signed in. Please sign in again.'),
        );
      }
      final data = await apiService.put(
        endPoint: 'Account/change-password',
        body: {
          'currentPassword': currentPassword,
          'newPassword': newPassword,
          'confirmPassword': confirmPassword,
        },
        token: trimmed,
      );
      return Right(ChangePasswordModel.fromJson(data));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, LogoutModel>> logout() async {
    try {
      final localStorage = LocalStorageService();
      final localStorageToken = await localStorage.getToken();
      final token = localStorageToken;
      final data = await apiService.post(
        endPoint: 'Account/logout',
        body: {},
        token: token,
      );
      return Right(LogoutModel.fromJson(data));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }
}
