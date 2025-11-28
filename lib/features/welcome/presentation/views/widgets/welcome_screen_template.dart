import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/core/utils/functions/styles.dart';
import 'package:move_on/core/widgets/custom_background_widget.dart';
import 'package:move_on/features/welcome/presentation/views/widgets/custom_back_button.dart';
import 'package:move_on/features/welcome/presentation/views/widgets/custom_button.dart';
import 'package:move_on/features/welcome/presentation/views/widgets/custom_top_indicator.dart';

class WelcomeScreenTemplate extends StatelessWidget {
  const WelcomeScreenTemplate({
    super.key,
    required this.backgroundImage,
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.nextRoute,
  });

  final String backgroundImage;
  final String title;
  final String subtitle;
  final double progress;
  final String nextRoute;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          CustomBackgroundWidget(
            imagePath: backgroundImage,
            fit: BoxFit.cover,
            alignmentGeometry: AlignmentGeometry.xy(0.15, 0),
          ),

          Align(
            alignment: AlignmentGeometry.topCenter,
            child: CustomTopIndicator(progress: progress),
          ),

          Align(
            alignment: Alignment(0, 0.55),
            child: Text(
              title,
              style: Styles.textStyle36,
              textAlign: TextAlign.center,
            ),
          ),

          Align(
            alignment: Alignment(0, 0.66),
            child: Text(
              subtitle,
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
              radius: 30,
              style: Styles.textStyle20.copyWith(fontWeight: FontWeight.bold),
              onTap: () {
                context.push(nextRoute);
              },
            ),
          ),

          Align(
            alignment: const Alignment(-0.9, 0.9),
            child: const CustomBackButton(radius: 30),
          ),
        ],
      ),
    );
  }
}
