import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/core/utils/functions/styles.dart';
import 'package:move_on/core/widgets/custom_text_field.dart';
import 'package:move_on/features/sign/presentation/views/widgets/custom_signing_view.dart';
import 'package:move_on/features/sign/presentation/views/widgets/custom_text_span_widget.dart';
import 'package:move_on/features/sign/presentation/views/widgets/social_icon.dart';
import 'package:move_on/features/welcome/presentation/views/widgets/custom_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInViewBody extends StatelessWidget {
  const SignInViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          CustomSigningView(
            title: 'Sign In To Move On',
            subTitle: 'Let’s personalize your fitness with AI',
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Email Address',
                style: Styles.textStyle16.copyWith(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Work Sans',
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          CustomFormTextField(
            prefixIcon: Icons.mail_outline,
            hintText: 'Email Address',
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Password',
                style: Styles.textStyle16.copyWith(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Work Sans',
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          CustomFormTextField(
            hintText: "Password",
            isPassword: true,
            prefixIcon: Icons.lock_outlined,
          ),
          SizedBox(height: 10),
          CustomButton(
            text: 'Sign In',
            width: 360,
            height: 56,
            style: Styles.textStyle16.copyWith(fontFamily: 'Work Sans'),
            radius: 19,
            onTap: () {
              GoRouter.of(context).push(AppRouter.kProfileView);
            },
          ),
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SocialIcon(icon: FontAwesomeIcons.google),
              const SizedBox(width: 20),
              SocialIcon(icon: FontAwesomeIcons.facebook),
            ],
          ),

          SizedBox(height: 40),

          CustomTextSpanWidget(
            text: 'Don’t have an account? ',
            textSpan: 'Sign Up',
            route: AppRouter.kSignUpView,
          ),
          SizedBox(height: 10),
          CustomTextSpanWidget(
            text: '',
            textSpan: 'Forget Password',
            route: AppRouter.kForgetPasswordView,
          ),
        ],
      ),
    );
  }
}
