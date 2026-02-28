import 'package:dartz/dartz.dart';
import 'package:move_on/core/errors/failures.dart';
import 'package:move_on/features/authentication/data/models/forgot_password_model.dart';
import 'package:move_on/features/authentication/data/models/logout_model.dart';
import 'package:move_on/features/authentication/data/models/resend_otp_model.dart';
import 'package:move_on/features/authentication/data/models/reset_password_model.dart';
import 'package:move_on/features/authentication/data/models/send_otp_model.dart';
import 'package:move_on/features/authentication/data/models/signin_model.dart';
import 'package:move_on/features/authentication/data/models/signup_model.dart';
import 'package:move_on/features/authentication/data/models/verify_otp_model.dart';
import 'package:move_on/features/authentication/data/repos/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  @override
  Future<Either<Failure, ForgotPasswordModel>> forgotPassword({
    required String email,
  }) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, LogoutModel>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ResendOtpModel>> resendOtp({required String email}) {
    // TODO: implement resendOtp
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ResetPasswordModel>> resetPassword({
    required String newPassword,
    required String confirmPassword,
  }) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, SendOtpModel>> sendOtp({required String email}) {
    // TODO: implement sendOtp
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, SigninModel>> signIn({
    required String email,
    required String password,
  }) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, SignupModel>> signUp({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) {
    // TODO: implement signUp
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, VerifyOtpModel>> verifyOtp({required String otp}) {
    // TODO: implement verifyOtp
    throw UnimplementedError();
  }
}
