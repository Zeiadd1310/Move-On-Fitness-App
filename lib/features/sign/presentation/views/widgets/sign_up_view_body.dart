import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/constants.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/core/utils/functions/assets.dart';

import 'package:move_on/core/utils/functions/styles.dart';
import 'package:move_on/core/widgets/custom_text_field.dart';
import 'package:move_on/features/welcome/presentation/views/widgets/custom_button.dart';

class SignUpViewBody extends StatelessWidget {
  const SignUpViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: 314,
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/images/chestpressdark.png',
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black54,
                            Colors.black,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 100,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Image.asset(AssetsData.logo, width: 86, height: 86),
                    SizedBox(height: 16),
                    Text(
                      'Sign Up For Free',
                      style: Styles.textStyle30.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Quickly make your account in 1 minute',
                      style: Styles.textStyle16,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
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
          Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Confirm Password',
                style: Styles.textStyle16.copyWith(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Work Sans',
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          CustomFormTextField(
            hintText: "Password Again",
            isPassword: true,
            prefixIcon: Icons.lock_outlined,
          ),

          CustomFormTextField(
            hintText: "Error: Password Doesn't Match",

            prefixIcon: Icons.error_outline_sharp,
          ),
          SizedBox(height: 6),
          CustomButton(
            text: 'Sign Up',
            width: 360,
            height: 56,
            style: Styles.textStyle16.copyWith(fontFamily: 'Work Sans'),
            radius: 19,
          ),
          SizedBox(height: 30),
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
