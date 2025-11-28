import 'package:flutter/material.dart';
import 'package:move_on/core/utils/functions/assets.dart';
import 'package:move_on/core/utils/functions/styles.dart';
import 'package:move_on/core/widgets/custom_background_widget.dart';
import 'package:move_on/features/welcome/presentation/views/widgets/custom_back_button.dart';
import 'package:move_on/features/welcome/presentation/views/widgets/custom_button.dart';
import 'package:move_on/features/welcome/presentation/views/widgets/custom_top_indicator.dart';

class FirstWelcomeViewBody extends StatelessWidget {
  const FirstWelcomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          CustomBackgroundWidget(
            imagePath: AssetsData.firstWelcomeBackground,
            fit: BoxFit.cover,
            alignmentGeometry: AlignmentGeometry.xy(0.15, 0),
          ),
          Align(
            alignment: AlignmentGeometry.topCenter,
            child: CustomTopIndicator(progress: 0.3),
          ),
          // SizedBox(height: 100),
          Align(
            alignment: Alignment(0, 0.55),
            child: Text(
              'Personalized       Fitness Plans',
              style: Styles.textStyle36,
              textAlign: TextAlign.center,
            ),
          ),
          Align(
            alignment: Alignment(0, 0.66),
            child: Text(
              'Choose your own fitness journey with AI. 🏋️‍♀️',
              style: Styles.textStyle16,
              textAlign: TextAlign.center,
            ),
          ),
          Align(
            alignment: const Alignment(0.9, 0.9),
            child: CustomButton(
              text: 'Next',
              width: 127.31,
              height: 51.85,
              style: Styles.textStyle20.copyWith(fontWeight: FontWeight.bold),
              radius: 30,
            ),
          ),
          Align(
            alignment: const Alignment(-0.9, 0.9),
            child: CustomBackButton(radius: 30),
          ),
        ],
      ),
    );
  }
}
