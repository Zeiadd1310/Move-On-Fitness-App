import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/core/utils/functions/responsive_helper.dart';
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
    this.onNextTap,
  });

  final String backgroundImage;
  final String title;
  final String subtitle;
  final double progress;
  final String nextRoute;
  final VoidCallback? onNextTap;

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);
    final titleFontSize = responsive.fontSize(36);
    final subtitleFontSize = responsive.fontSize(16);
    final buttonFontSize = responsive.fontSize(20);
    final nextButtonWidth = responsive.buttonWidth(127.31);
    final nextButtonHeight = responsive.buttonHeight(51.85);
    final backButtonWidth = responsive.buttonWidth(57.29);
    final backButtonHeight = responsive.buttonHeight(56);
    final horizontalPadding = responsive.horizontalPadding();

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          CustomBackgroundWidget(
            imagePath: backgroundImage,
            fit: BoxFit.cover,
            alignmentGeometry: AlignmentGeometry.xy(0.15, 0),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: responsive.heightPercent(0.4),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(0.9),
                  ],
                ),
              ),
            ),
          ),

          Align(
            alignment: AlignmentGeometry.topCenter,
            child: CustomTopIndicator(progress: progress),
          ),

          Align(
            alignment: Alignment(0, 0.55),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Text(
                title,
                style: Styles.textStyle36.copyWith(fontSize: titleFontSize),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          Align(
            alignment: Alignment(0, 0.66),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Text(
                subtitle,
                style: Styles.textStyle16.copyWith(fontSize: subtitleFontSize),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          Align(
            alignment: const Alignment(0.9, 0.9),
            child: CustomButton(
              text: 'Next',
              width: nextButtonWidth,
              height: nextButtonHeight,
              radius: 30,
              style: Styles.textStyle20.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: buttonFontSize,
              ),
              onTap: () {
                onNextTap?.call();
                context.push(nextRoute);
              },
            ),
          ),

          Align(
            alignment: const Alignment(-0.9, 0.9),
            child: CustomBackButton(
              radius: 30,
              height: backButtonHeight,
              width: backButtonWidth,
            ),
          ),
        ],
      ),
    );
  }
}
