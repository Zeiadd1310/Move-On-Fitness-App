import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_on/features/authentication/data/repos/auth_repo.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepo authRepo;

  SignUpCubit(this.authRepo) : super(SignUpInitial());

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    emit(SignUpLoading());
    final result = await authRepo.signUp(
      name: name,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
    result.fold(
      (failure) => emit(SignUpFailure(failure.errMessage)),
      (signupModel) => emit(SignUpSuccess(signupModel.token)),
    );
  }
}
