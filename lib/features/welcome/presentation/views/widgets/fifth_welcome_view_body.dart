import 'package:flutter/material.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/core/utils/functions/assets.dart';
import 'package:move_on/features/welcome/presentation/views/widgets/welcome_screen_template.dart';

class FifthWelcomeViewBody extends StatelessWidget {
  const FifthWelcomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const WelcomeScreenTemplate(
      backgroundImage: AssetsData.fifthWelcomeBackground,
      title: 'Nutrition & Diet Guidance',
      subtitle: 'Lose weight and get fit with Move On ! 🥒',
      progress: 1,
      nextRoute: AppRouter.kHomeView,
    );
  }
}
