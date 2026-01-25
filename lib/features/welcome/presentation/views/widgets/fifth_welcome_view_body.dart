import 'package:flutter/material.dart';
import 'package:move_on/core/services/local_storage_service.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/core/utils/functions/assets.dart';
import 'package:move_on/features/welcome/presentation/views/widgets/welcome_screen_template.dart';
import 'package:move_on/features/welcome/view_models/welcome_view_model.dart';

class FifthWelcomeViewBody extends StatefulWidget {
  const FifthWelcomeViewBody({super.key});

  @override
  State<FifthWelcomeViewBody> createState() => _FifthWelcomeViewBodyState();
}

class _FifthWelcomeViewBodyState extends State<FifthWelcomeViewBody> {
  late final WelcomeViewModel _welcomeViewModel;

  @override
  void initState() {
    super.initState();
    _welcomeViewModel = WelcomeViewModel(LocalStorageService());
  }

  @override
  Widget build(BuildContext context) {
    return WelcomeScreenTemplate(
      backgroundImage: AssetsData.fifthWelcomeBackground,
      title: 'Nutrition & Diet Guidance',
      subtitle: 'Lose weight and get fit with Move On ! 🥒',
      progress: 1,
      nextRoute: AppRouter.kSignUpView,
      onNextTap: () async {
        await _welcomeViewModel.completeWelcome();
      },
    );
  }
}
