import 'dart:async';

import 'package:move_on/core/services/local_storage_service.dart';

enum SplashDestination { welcome, signIn, home }

class SplashViewModel {
  final LocalStorageService _localStorageService;

  SplashViewModel(this._localStorageService);

  Future<SplashDestination> decideNavigation() async {
    final isFirstTime = await _localStorageService.isFirstTime();
    final isSignedIn = await _localStorageService.isSignedIn();

    if (isFirstTime) {
      return SplashDestination.welcome;
    } else if (isSignedIn) {
      return SplashDestination.home;
    } else {
      return SplashDestination.signIn;
    }
  }
}
