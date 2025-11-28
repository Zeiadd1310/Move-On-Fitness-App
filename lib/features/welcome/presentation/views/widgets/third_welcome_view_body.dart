import 'package:flutter/material.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/core/utils/functions/assets.dart';
import 'package:move_on/features/welcome/presentation/views/widgets/welcome_screen_template.dart';

class ThirdWelcomeViewBody extends StatelessWidget {
  const ThirdWelcomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const WelcomeScreenTemplate(
      backgroundImage: AssetsData.thirdWelcomeBackground,
      title: 'Virtual AI Coach Mentoring',
      subtitle: 'Say goodbye to manual coaching! 👋',
      progress: 0.6,
      nextRoute: AppRouter.kFourthWelcome,
    );
  }
}
