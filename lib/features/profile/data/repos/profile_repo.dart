import 'package:move_on/features/profile/data/models/user_profile_model.dart';

abstract class ProfileRepo {
  Future<String> deleteAccount();
  Future<UserProfileModel> getMyProfile();
  Future<String> uploadProfilePicture({required String imagePath});
  Future<String> updateProfile({
    required String fullName,
    required String email,
    required String dateOfBirth,
    required String mobileNumber,
    required String weight,
    required String height,
    required String profilePictureUrl,
  });
}
