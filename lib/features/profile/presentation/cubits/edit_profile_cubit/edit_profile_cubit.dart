import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_on/features/profile/data/repos/profile_repo.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final ProfileRepo profileRepo;

  EditProfileCubit(this.profileRepo) : super(EditProfileInitial());

  Future<void> updateProfile({
    required String fullName,
    required String email,
    required String dateOfBirth,
    required String mobileNumber,
    required String weight,
    required String height,
  }) async {
    emit(EditProfileLoading());
    try {
      final message = await profileRepo.updateProfile(
        fullName: fullName,
        email: email,
        dateOfBirth: dateOfBirth,
        mobileNumber: mobileNumber,
        weight: weight,
        height: height,
      );
      emit(EditProfileSuccess(message));
    } catch (e) {
      emit(EditProfileFailure(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
