part of 'sign_in_cubit.dart';

abstract class SignInState {}

class SignInInitial extends SignInState {}

class SignInLoading extends SignInState {}

class SignInSuccess extends SignInState {
  final String token;
  final OAuthAccountSnapshot? oauthProfile;

  SignInSuccess(this.token, {this.oauthProfile});
}

class SignInFailure extends SignInState {
  final String errMessage;
  SignInFailure(this.errMessage);
}
