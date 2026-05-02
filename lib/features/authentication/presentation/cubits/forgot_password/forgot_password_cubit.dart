import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_on/features/authentication/data/repos/auth_repo.dart';
import 'package:move_on/features/authentication/presentation/cubits/forgot_password/forgot_password_state.dart';

export 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final AuthRepo authRepo;

  ForgotPasswordCubit(this.authRepo) : super(ForgotPasswordInitial());

  Future<void> forgotPassword({required String email}) async {
    emit(ForgotPasswordLoading());
    final result = await authRepo.forgotPassword(email: email);
    result.fold(
      (failure) => emit(ForgotPasswordFailure(failure.errMessage)),
      (model) {
        final msg = model.message?.trim();
        emit(
          ForgotPasswordSuccess(
            (msg == null || msg.isEmpty) ? 'Reset link sent.' : msg,
            resetToken: model.token,
          ),
        );
      },
    );
  }
}
