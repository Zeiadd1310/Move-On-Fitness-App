import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_on/core/models/oauth_account_snapshot.dart';
import 'package:move_on/core/services/social_auth_service.dart';
import 'package:move_on/features/authentication/data/repos/auth_repo.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this.authRepo, [SocialAuthService? socialAuth])
    : _socialAuth = socialAuth ?? SocialAuthService(),
      super(SignInInitial());

  final AuthRepo authRepo;
  final SocialAuthService _socialAuth;

  Future<void> signIn({required String email, required String password}) async {
    emit(SignInLoading());
    final result = await authRepo.signIn(email: email, password: password);
    result.fold(
      (failure) => emit(SignInFailure(failure.errMessage)),
      (signinModel) => emit(SignInSuccess(signinModel.token ?? '')),
    );
  }

  Future<void> signInWithGoogle() async {
    emit(SignInLoading());
    try {
      final bundle = await _socialAuth.completeGoogleSignInForBackend();
      if (bundle == null) {
        emit(SignInInitial());
        return;
      }
      final result =
          await authRepo.signInWithGoogle(idToken: bundle.idToken);
      result.fold(
        (failure) => emit(SignInFailure(failure.errMessage)),
        (signinModel) => emit(
          SignInSuccess(
            signinModel.token ?? '',
            oauthProfile: bundle.profile,
          ),
        ),
      );
    } on UnsupportedError catch (e) {
      emit(SignInFailure(e.message ?? 'Google sign-in is not available here.'));
    } on StateError catch (e) {
      emit(SignInFailure(e.message));
    } catch (e) {
      emit(SignInFailure(e.toString()));
    }
  }

  Future<void> signInWithFacebook() async {
    emit(SignInLoading());
    try {
      final bundle = await _socialAuth.completeFacebookSignInForBackend();
      if (bundle == null) {
        emit(SignInInitial());
        return;
      }
      final result = await authRepo.signInWithFacebook(
        accessToken: bundle.accessToken,
      );
      result.fold(
        (failure) => emit(SignInFailure(failure.errMessage)),
        (signinModel) => emit(
          SignInSuccess(
            signinModel.token ?? '',
            oauthProfile: bundle.profile,
          ),
        ),
      );
    } on UnsupportedError catch (e) {
      emit(SignInFailure(e.message ?? 'Facebook sign-in is not available here.'));
    } on StateError catch (e) {
      emit(SignInFailure(e.message));
    } catch (e) {
      emit(SignInFailure(e.toString()));
    }
  }
}
