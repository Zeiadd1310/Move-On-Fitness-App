import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/constants.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/core/utils/functions/assets.dart';
import 'package:move_on/core/utils/functions/styles.dart';
import 'package:move_on/features/splash/presentation/views/widgets/custom_background_widget.dart';
import 'package:move_on/features/welcome/presentation/widgets/custom_button.dart';

class GetStartedViewBody extends StatelessWidget {
  const GetStartedViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const CustomBackgroundWidget(),
          Align(
            alignment: const Alignment(0, -0.6),
            child: Image.asset(
              AssetsData.logo,
              width: MediaQuery.of(context).size.width * 0.7,
              fit: BoxFit.contain,
            ),
          ),
          Align(
            alignment: const Alignment(0, 0.03),
            child: const Text(
              'Ready to Transform? Let\'s Move On!',
              style: Styles.textStyle36,
              textAlign: TextAlign.center,
            ),
          ),
          Align(
            alignment: const Alignment(0, 0.23),
            child: const Text(
              'Your personal fitness AI Assistant 🤖',
              style: Styles.textStyle16,
              textAlign: TextAlign.center,
            ),
          ),
          Align(
            alignment: const Alignment(0, 0.45),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: CustomButton(
                text: 'Get Started',
                width: 207,
                height: 64,
                style: Styles.textStyle20.copyWith(fontWeight: FontWeight.bold),
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
                  style: Styles.textStyle16,
                  children: [
                    TextSpan(
                      text: 'Sign In',
                      style: Styles.textStyle16.copyWith(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationColor: kPrimaryColor,
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
