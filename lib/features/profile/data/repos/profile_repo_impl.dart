import 'package:move_on/core/services/local_storage_service.dart';
import 'package:move_on/core/errors/failures.dart';
import 'package:move_on/core/utils/functions/api_service.dart';
import 'package:dio/dio.dart';
import 'package:move_on/features/profile/data/models/delete_account_model.dart';
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
}
