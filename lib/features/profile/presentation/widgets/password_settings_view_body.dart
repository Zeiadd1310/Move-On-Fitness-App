import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/constants.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/core/utils/functions/styles.dart';
import 'package:move_on/core/widgets/custom_text_field.dart';
import 'package:move_on/features/welcome/presentation/views/widgets/custom_button.dart';
import 'package:move_on/features/workout/presentation/views/widgets/custom_assessment_text_widget.dart';

class PasswordSettingsViewBody extends StatelessWidget {
  const PasswordSettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAssessmentTextWidget(text: 'Password Settings'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current Password',
                    style: Styles.textStyle20.copyWith(
                      fontFamily: 'League Spartan',
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 20),
                  CustomFormTextField(
                    hintText: 'Current Password',
                    isPassword: true,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        GoRouter.of(
                          context,
                        ).push(AppRouter.kForgetPasswordView);
                      },
                      child: Text(
                        'Forgot Password?',
                        style: Styles.textStyle16.copyWith(
                          fontFamily: 'League Spartan',
                          fontWeight: FontWeight.w500,
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  Text(
                    'New Password',
                    style: Styles.textStyle20.copyWith(
                      fontFamily: 'League Spartan',
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 20),
                  CustomFormTextField(
                    hintText: 'New Password',
                    isPassword: true,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Confirm New Password',
                    style: Styles.textStyle20.copyWith(
                      fontFamily: 'League Spartan',
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 20),
                  CustomFormTextField(
                    hintText: 'Confirm Password',
                    isPassword: true,
                  ),
                  SizedBox(height: 100),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomButton(
                      text: 'Change Password',
                      width: 220,
                      height: 50,
                      style: Styles.textStyle18.copyWith(
                        fontFamily: 'League Spartan',
                        fontWeight: FontWeight.w500,
                      ),
                      radius: 100,
                      onTap: () {
                        GoRouter.of(context).push(AppRouter.kSettingsView);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
