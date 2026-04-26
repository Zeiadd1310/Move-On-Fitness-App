import 'package:move_on/core/services/local_storage_service.dart';
import 'package:move_on/core/errors/failures.dart';
import 'package:move_on/core/utils/functions/api_service.dart';
import 'package:dio/dio.dart';
import 'package:move_on/features/profile/data/models/delete_account_model.dart';
import 'package:move_on/features/profile/data/models/edit_profile_model.dart';
import 'package:move_on/features/profile/data/models/profile_picture_model.dart';
import 'package:move_on/features/profile/data/models/user_profile_model.dart';
import 'package:move_on/features/profile/data/repos/profile_repo.dart';

class ProfileRepoImpl implements ProfileRepo {
  final ApiService apiService;
  final LocalStorageService localStorageService;

  ProfileRepoImpl({
    required this.apiService,
    required this.localStorageService,
  });

  @override
  Future<String> deleteAccount() async {
    try {
      final token = await localStorageService.getToken();
      final response = await apiService.delete(
        endPoint: 'Account/deleteaccount',
        token: token,
      );
      final model = DeleteAccountModel.fromJson(response);
      return model.message ?? 'Account deleted successfully';
    } on DioException catch (e) {
      throw Exception(ServerFailure.fromDioError(e).errMessage);
    } catch (_) {
      throw Exception('Unexpected error, please try again later.');
    }
  }

  @override
  Future<UserProfileModel> getMyProfile() async {
    try {
      final token = await localStorageService.getToken();
      final response = await apiService.get(
        endPoint: 'Account/GetMyProfile',
        token: token,
      );
      final remoteProfile = UserProfileModel.fromJson(response);
      final pending = await localStorageService.getPendingProfileData();

      // Backend profile currently does not always return all app fields.
      // Keep locally entered values when server returns empty values.
      final mergedProfile = UserProfileModel(
        fullName: remoteProfile.fullName.isNotEmpty
            ? remoteProfile.fullName
            : (pending['fullName'] ?? ''),
        email: remoteProfile.email.isNotEmpty
            ? remoteProfile.email
            : (pending['email'] ?? ''),
        dateOfBirth: remoteProfile.dateOfBirth,
        mobileNumber: remoteProfile.mobileNumber,
        weight: remoteProfile.weight.isNotEmpty
            ? remoteProfile.weight
            : (pending['weight'] ?? ''),
        height: remoteProfile.height.isNotEmpty
            ? remoteProfile.height
            : (pending['height'] ?? ''),
        profilePictureUrl: remoteProfile.profilePictureUrl,
        gender: remoteProfile.gender.isNotEmpty
            ? remoteProfile.gender
            : (pending['gender'] ?? ''),
      );

      await localStorageService.saveCachedUserProfile(mergedProfile.toJson());
      return mergedProfile;
    } on DioException catch (e) {
      throw Exception(ServerFailure.fromDioError(e).errMessage);
    } catch (_) {
      throw Exception('Unexpected error, please try again later.');
    }
  }

  @override
  Future<String> uploadProfilePicture({required String imagePath}) async {
    try {
      final token = await localStorageService.getToken();
      final fileName = imagePath.split(RegExp(r'[\\/]')).last;
      final response = await apiService.postFormData(
        endPoint: 'Account/upload-picture',
        token: token,
        body: FormData.fromMap({
          'File': await MultipartFile.fromFile(imagePath, filename: fileName),
        }),
      );
      final model = ProfilePictureModel.fromJson(response);
      return model.profilePictureUrl ?? '';
    } on DioException catch (e) {
      throw Exception(ServerFailure.fromDioError(e).errMessage);
    } catch (_) {
      throw Exception('Unexpected error, please try again later.');
    }
  }

  @override
  Future<String> updateProfile({
    required String fullName,
    required String email,
    required String dateOfBirth,
    required String mobileNumber,
    required String weight,
    required String height,
    required String profilePictureUrl,
  }) async {
    try {
      final token = await localStorageService.getToken();
      final response = await apiService.put(
        endPoint: 'Account/MyProfile',
        token: token,
        body: {
          'name': fullName,
          'fullName': fullName,
          'email': email,
          'dateOfBirth': dateOfBirth,
          'mobileNumber': mobileNumber,
          'phoneNumber': mobileNumber,
          'weight': weight,
          'height': height,
          'profilePictureUrl': profilePictureUrl,
        },
      );
      await localStorageService.saveCachedUserProfile({
        'fullName': fullName,
        'email': email,
        'dateOfBirth': dateOfBirth,
        'mobileNumber': mobileNumber,
        'weight': weight,
        'height': height,
        'profilePictureUrl': profilePictureUrl,
      });
      await localStorageService.savePendingProfileData(
        fullName: fullName,
        email: email,
        weight: weight,
        height: height,
      );
      final model = EditProfileModel.fromJson(response);
      return model.message ?? 'Profile updated successfully';
    } on DioException catch (e) {
      throw Exception(ServerFailure.fromDioError(e).errMessage);
    } catch (_) {
      throw Exception('Unexpected error, please try again later.');
    }
  }
}
