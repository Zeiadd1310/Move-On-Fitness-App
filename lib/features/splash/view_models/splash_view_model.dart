import 'dart:async';

import 'package:move_on/core/services/local_storage_service.dart';
import 'package:move_on/core/services/server_onboarding_sync.dart';

enum SplashDestination { welcome, signIn, bodyData, home }

class SplashViewModel {
  final LocalStorageService _localStorageService;
  final ServerOnboardingSync _serverOnboardingSync;

  SplashViewModel(
    this._localStorageService,
    this._serverOnboardingSync,
  );

  Future<SplashDestination> decideNavigation() async {
    final isFirstTime = await _localStorageService.isFirstTime();
    final isSignedIn = await _localStorageService.isSignedIn();

    if (!isFirstTime && isSignedIn) {
      await _serverOnboardingSync.hydrateFromServer();
    }

    final isBodyDataCompleted = isSignedIn
        ? await _localStorageService.isBodyDataCompleted()
        : false;

    if (isFirstTime) {
      return SplashDestination.welcome;
    } else if (isSignedIn) {
      if (isBodyDataCompleted) {
        return SplashDestination.home;
      } else {
        return SplashDestination.bodyData;
      }
    } else {
      return SplashDestination.signIn;
    }
  }
}
