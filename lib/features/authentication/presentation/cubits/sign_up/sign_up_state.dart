part of 'sign_up_cubit.dart';

abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {
  final String token;
  final OAuthAccountSnapshot? oauthProfile;

  SignUpSuccess(this.token, {this.oauthProfile});
}

class SignUpFailure extends SignUpState {
  final String errMessage;
  SignUpFailure(this.errMessage);
}
