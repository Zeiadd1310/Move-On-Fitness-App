import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_on/core/models/oauth_account_snapshot.dart';
import 'package:move_on/core/services/social_auth_service.dart';
import 'package:move_on/features/authentication/data/repos/auth_repo.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this.authRepo, [SocialAuthService? socialAuth])
    : _socialAuth = socialAuth ?? SocialAuthService(),
      super(SignUpInitial());

  final AuthRepo authRepo;
  final SocialAuthService _socialAuth;

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

  Future<void> signUpWithGoogle() async {
    emit(SignUpLoading());
    try {
      final bundle = await _socialAuth.completeGoogleSignInForBackend();
      if (bundle == null) {
        emit(SignUpInitial());
        return;
      }
      final result =
          await authRepo.signInWithGoogle(idToken: bundle.idToken);
      result.fold(
        (failure) => emit(SignUpFailure(failure.errMessage)),
        (signinModel) => emit(
          SignUpSuccess(
            signinModel.token ?? '',
            oauthProfile: bundle.profile,
          ),
        ),
      );
    } on UnsupportedError catch (e) {
      emit(SignUpFailure(e.message ?? 'Google sign-in is not available here.'));
    } on StateError catch (e) {
      emit(SignUpFailure(e.message));
    } catch (e) {
      emit(SignUpFailure(e.toString()));
    }
  }

  Future<void> signUpWithFacebook() async {
    emit(SignUpLoading());
    try {
      final bundle = await _socialAuth.completeFacebookSignInForBackend();
      if (bundle == null) {
        emit(SignUpInitial());
        return;
      }
      final result = await authRepo.signInWithFacebook(
        accessToken: bundle.accessToken,
      );
      result.fold(
        (failure) => emit(SignUpFailure(failure.errMessage)),
        (signinModel) => emit(
          SignUpSuccess(
            signinModel.token ?? '',
            oauthProfile: bundle.profile,
          ),
        ),
      );
    } on UnsupportedError catch (e) {
      emit(SignUpFailure(e.message ?? 'Facebook sign-in is not available here.'));
    } on StateError catch (e) {
      emit(SignUpFailure(e.message));
    } catch (e) {
      emit(SignUpFailure(e.toString()));
    }
  }
}
