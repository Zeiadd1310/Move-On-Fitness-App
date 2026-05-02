abstract class ForgotPasswordState {}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordLoading extends ForgotPasswordState {}

class ForgotPasswordSuccess extends ForgotPasswordState {
  final String message;
  final String? resetToken;

  ForgotPasswordSuccess(this.message, {this.resetToken});
}

class ForgotPasswordFailure extends ForgotPasswordState {
  final String errMessage;

  ForgotPasswordFailure(this.errMessage);
}
