import 'package:flutter/material.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/core/utils/functions/assets.dart';
import 'package:move_on/features/welcome/presentation/views/widgets/welcome_screen_template.dart';

class FirstWelcomeViewBody extends StatelessWidget {
  const FirstWelcomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return WelcomeScreenTemplate(
      backgroundImage: AssetsData.firstWelcomeBackground,
      title: 'Personalized       Fitness Plans',
      subtitle: 'Choose your own fitness journey with AI. 🏋️‍♀️',
      progress: 0.2,
      nextRoute: AppRouter.kSecondWelcome,
    );
  }
}
