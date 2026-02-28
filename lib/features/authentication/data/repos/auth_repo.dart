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

abstract class AuthRepo {
  Future<Either<Failure, SigninModel>> signIn({
    required String email,
    required String password,
  });

  Future<Either<Failure, SignupModel>> signUp({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  });

  Future<Either<Failure, ForgotPasswordModel>> forgotPassword({
    required String email,
  });

  Future<Either<Failure, SendOtpModel>> sendOtp({required String email});

  Future<Either<Failure, ResendOtpModel>> resendOtp({required String email});

  Future<Either<Failure, VerifyOtpModel>> verifyOtp({required String otp});

  Future<Either<Failure, ResetPasswordModel>> resetPassword({
    required String newPassword,
    required String confirmPassword,
  });

  Future<Either<Failure, LogoutModel>> logout();
}
