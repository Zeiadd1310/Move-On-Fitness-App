import 'package:flutter/material.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/core/utils/functions/assets.dart';
import 'package:move_on/features/welcome/presentation/views/widgets/welcome_screen_template.dart';

class SecondWelcomeViewBody extends StatelessWidget {
  const SecondWelcomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const WelcomeScreenTemplate(
      backgroundImage: AssetsData.secondtWelcomeBackground,
      title: 'Extensive Workout Libraries',
      subtitle: 'Explore ~100K exercises made for you! 💪',
      progress: 0.4,
      nextRoute: AppRouter.kThirdWelcome,
    );
  }
}
