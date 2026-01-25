import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/constants.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/core/utils/functions/assets.dart';
import 'package:move_on/core/utils/functions/responsive_helper.dart';
import 'package:move_on/core/utils/functions/styles.dart';
import 'package:move_on/core/widgets/custom_background_widget.dart';
import 'package:move_on/features/welcome/presentation/views/widgets/custom_button.dart';

class GetStartedViewBody extends StatelessWidget {
  const GetStartedViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);
    final logoWidth = responsive.widthPercent(0.7);
    final titleFontSize = responsive.fontSize(36);
    final subtitleFontSize = responsive.fontSize(16);
    final buttonWidth = responsive.buttonWidth(207);
    final buttonHeight = responsive.buttonHeight(64);
    final horizontalPadding = responsive.horizontalPadding();
    final fontSize = responsive.fontSize(16);
    
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          CustomBackgroundWidget(
            imagePath: AssetsData.splashBackground,
            alignmentGeometry: AlignmentGeometry.xy(0.5, 0),
          ),
          Align(
            alignment: const Alignment(0, -0.6),
            child: Image.asset(
              AssetsData.logo,
              width: logoWidth,
              fit: BoxFit.contain,
            ),
          ),
          Align(
            alignment: const Alignment(0, 0.03),
            child: Text(
              'Ready to Transform? Let\'s Move On!',
              style: Styles.textStyle36.copyWith(fontSize: titleFontSize),
              textAlign: TextAlign.center,
            ),
          ),
          Align(
            alignment: const Alignment(0, 0.23),
            child: Text(
              'Your personal fitness AI Assistant 🤖',
              style: Styles.textStyle16.copyWith(fontSize: subtitleFontSize),
              textAlign: TextAlign.center,
            ),
          ),
          Align(
            alignment: const Alignment(0, 0.45),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: CustomButton(
                text: 'Get Started',
                width: buttonWidth,
                height: buttonHeight,
                radius: 20,
                style: Styles.textStyle20.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: responsive.fontSize(20),
                ),
                onTap: () {
                  GoRouter.of(context).push(AppRouter.kFirstWelcome);
                },
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, 0.6),
            child: GestureDetector(
              onTap: () {
                GoRouter.of(context).push(AppRouter.kSignInView);
              },
              child: Text.rich(
                TextSpan(
                  text: 'Already have account? ',
                  style: Styles.textStyle16.copyWith(fontSize: fontSize),
                  children: [
                    TextSpan(
                      text: 'Sign In',
                      style: Styles.textStyle16.copyWith(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationColor: kPrimaryColor,
                        fontSize: fontSize,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
