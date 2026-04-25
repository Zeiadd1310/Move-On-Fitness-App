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
    required String profilePictureUrl,
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
        profilePictureUrl: profilePictureUrl,
      );
      emit(EditProfileSuccess(message));
    } catch (e) {
      emit(EditProfileFailure(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<void> uploadProfilePicture({required String imagePath}) async {
    emit(EditProfileImageUploadLoading());
    try {
      final imageUrl = await profileRepo.uploadProfilePicture(
        imagePath: imagePath,
      );
      if (imageUrl.trim().isEmpty) {
        emit(
          EditProfileImageUploadFailure(
            'Upload succeeded but image URL was empty. Please try again.',
          ),
        );
        return;
      }
      emit(EditProfileImageUploadSuccess(imageUrl));
    } catch (e) {
      emit(
        EditProfileImageUploadFailure(
          e.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }
}
