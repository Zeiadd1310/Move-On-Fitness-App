import 'package:flutter/material.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/core/utils/functions/assets.dart';
import 'package:move_on/features/welcome/presentation/views/widgets/welcome_screen_template.dart';

class FourthWelcomeViewBody extends StatelessWidget {
  const FourthWelcomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const WelcomeScreenTemplate(
      backgroundImage: AssetsData.fourthWelcomeBackground,
      title: 'Health Metrics &  Fitness Analytics',
      subtitle: 'Monitor your health profile with ease. 📈',
      progress: 0.8,
      nextRoute: AppRouter.kFifthWelcome,
    );
  }
}
