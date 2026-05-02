import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_on/features/authentication/data/repos/auth_repo.dart';
import 'package:move_on/features/profile/presentation/cubits/change_password_cubit/change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final AuthRepo authRepo;

  ChangePasswordCubit(this.authRepo) : super(ChangePasswordInitial());

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(ChangePasswordLoading());
    final result = await authRepo.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
    result.fold(
      (failure) => emit(ChangePasswordFailure(failure.errMessage)),
      (model) {
        final msg = model.message?.trim();
        emit(
          ChangePasswordSuccess(
            (msg == null || msg.isEmpty)
                ? 'Password changed successfully.'
                : msg,
          ),
        );
      },
    );
  }
}
