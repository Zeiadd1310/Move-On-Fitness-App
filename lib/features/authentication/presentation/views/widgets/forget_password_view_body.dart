import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/constants.dart';
import 'package:move_on/core/utils/functions/styles.dart';
import 'package:move_on/core/widgets/custom_background_widget.dart';
import 'package:move_on/features/authentication/presentation/views/widgets/reset_option_card.dart';
import 'package:move_on/features/welcome/presentation/views/widgets/custom_back_button.dart';
import 'package:move_on/features/welcome/presentation/views/widgets/custom_button.dart';

class ForgetPasswordViewBody extends StatelessWidget {
  const ForgetPasswordViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 80.0),
                child: CustomBackButton(
                  onTap: () => context.pop(),
                  width: 50,
                  height: 50,
                  radius: 18,
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  'Reset Password',
                  style: Styles.textStyle30.copyWith(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Work Sans',
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  'Select what method you’d like to reset.',
                  style: Styles.textStyle16.copyWith(
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Work Sans',
                    color: Color(0xffD7D8D9),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Center(
                child: SizedBox(
                  width: 380,
                  child: ResetOptionCard(
                    iconBg: Color(0xff24262B),
                    icon: Icons.email,
                    title: 'Send via Email',
                    subtitle:
                        'Seamlessly reset your password via email address.',
                    icColor: kPrimaryColor,
                  ),
                ),
              ),

              Center(
                child: SizedBox(
                  width: 380,
                  child: ResetOptionCard(
                    iconBg: Color(0xff24262B),
                    icon: Icons.phone,
                    title: 'Send via Phone Number',
                    subtitle: 'Seamlessly reset your password via 2 Numbers.',
                    icColor: Color(0xff2563EB),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Align(
                alignment: Alignment.center,
                child: CustomButton(
                  text: 'Reset Password',
                  width: 343,
                  height: 56,
                  style: Styles.textStyle18.copyWith(
                    fontFamily: 'Work Sans',
                    fontWeight: FontWeight.w600,
                  ),
                  radius: 19,
                ),
              ),
            ],
          ),

          Align(
            alignment: AlignmentGeometry.bottomCenter,
            child: SizedBox(
              width: 430,
              height: 275,
              child: CustomBackgroundWidget(
                imagePath: 'assets/images/password.png',
                alignmentGeometry: AlignmentGeometry.xy(0.8, 0.9),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
