part of 'sign_up_cubit.dart';

abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {
  final String token;
  SignUpSuccess(this.token);
}

class SignUpFailure extends SignUpState {
  final String errMessage;
  SignUpFailure(this.errMessage);
}
