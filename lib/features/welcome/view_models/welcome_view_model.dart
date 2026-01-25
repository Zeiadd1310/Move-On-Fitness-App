import 'package:move_on/core/services/local_storage_service.dart';

class WelcomeViewModel {
  final LocalStorageService _localStorageService;

  WelcomeViewModel(this._localStorageService);

  Future<void> completeWelcome() async {
    await _localStorageService.setNotFirstTime();
  }
}
