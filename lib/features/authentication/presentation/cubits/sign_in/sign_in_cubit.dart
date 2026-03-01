import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_on/features/authentication/data/repos/auth_repo.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final AuthRepo authRepo;

  SignInCubit(this.authRepo) : super(SignInInitial());

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(SignInLoading());
    final result = await authRepo.signIn(email: email, password: password);
    result.fold(
      (failure) => emit(SignInFailure(failure.errMessage)),
      (signinModel) => emit(SignInSuccess(signinModel.token ?? '')),
    );
  }
}
