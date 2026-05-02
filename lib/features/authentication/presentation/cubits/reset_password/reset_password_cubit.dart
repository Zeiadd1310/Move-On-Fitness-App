import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_on/features/authentication/data/repos/auth_repo.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final AuthRepo authRepo;

  ResetPasswordCubit(this.authRepo) : super(ResetPasswordInitial());

  Future<void> resetPassword({
    required String email,
    required String token,
    required String newPassword,
  }) async {
    emit(ResetPasswordLoading());
    final result = await authRepo.resetPassword(
      email: email,
      token: token,
      newPassword: newPassword,
    );
    result.fold(
      (failure) => emit(ResetPasswordFailure(failure.errMessage)),
      (model) {
        final msg = model.message?.trim();
        emit(
          ResetPasswordSuccess(
            (msg == null || msg.isEmpty) ? 'Password reset successful.' : msg,
          ),
        );
      },
    );
  }
}
