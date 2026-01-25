import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/core/services/local_storage_service.dart';
import 'package:move_on/core/utils/functions/app_router.dart';

import 'package:move_on/core/utils/functions/styles.dart';
import 'package:move_on/core/widgets/custom_error_snackbar.dart';
import 'package:move_on/core/widgets/custom_text_field.dart';
import 'package:move_on/features/sign/presentation/views/widgets/custom_signing_view.dart';
import 'package:move_on/features/sign/presentation/views/widgets/custom_text_span_widget.dart';
import 'package:move_on/features/welcome/presentation/views/widgets/custom_button.dart';

class SignUpViewBody extends StatelessWidget {
  const SignUpViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final localStorageService = LocalStorageService();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          CustomSigningView(
            title: 'Sign Up For Free',
            subTitle: 'Quickly make your account in 1 minute',
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

          CustomErrorSnackBar(
            message: "ERROR: Password Doesn't Match!",
            width: 360,
            height: 60,
          ),
          SizedBox(height: 30),
          CustomButton(
            text: 'Sign Up',
            width: 360,
            height: 56,
            style: Styles.textStyle16.copyWith(fontFamily: 'Work Sans'),
            radius: 19,
            onTap: () async {
              try {
                // حفظ حالة تسجيل الدخول
                await localStorageService.setSignedIn(true);
                if (context.mounted) {
                  GoRouter.of(context).push(AppRouter.kBodyDataView);
                }
              } catch (e) {
                // في حالة حدوث خطأ، ننتقل على أي حال
                if (context.mounted) {
                  GoRouter.of(context).push(AppRouter.kBodyDataView);
                }
              }
            },
          ),
          SizedBox(height: 30),
          CustomTextSpanWidget(
            text: 'Already have account? ',
            textSpan: 'Sign In',
            route: AppRouter.kSignInView,
          ),
        ],
      ),
    );
  }
}
