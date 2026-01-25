import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/core/services/local_storage_service.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/core/utils/functions/responsive_helper.dart';
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
    final responsive = ResponsiveHelper(context);
    final horizontalPadding = responsive.horizontalPadding();
    final spacing = responsive.spacing(10);
    final mediumSpacing = responsive.spacing(30);
    final fontSize = responsive.fontSize(16);
    final buttonWidth = responsive.buttonWidth(360);
    final buttonHeight = responsive.buttonHeight(56);
    final snackbarWidth = responsive.buttonWidth(360);
    final snackbarHeight = responsive.buttonHeight(60);
    
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomSigningView(
              title: 'Sign Up For Free',
              subTitle: 'Quickly make your account in 1 minute',
            ),
            Padding(
              padding: EdgeInsets.only(left: horizontalPadding),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Email Address',
                  style: Styles.textStyle16.copyWith(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Work Sans',
                    fontSize: fontSize,
                  ),
                ),
              ),
            ),
            SizedBox(height: spacing),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: CustomFormTextField(
                prefixIcon: Icons.mail_outline,
                hintText: 'Email Address',
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: horizontalPadding, top: spacing),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Password',
                  style: Styles.textStyle16.copyWith(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Work Sans',
                    fontSize: fontSize,
                  ),
                ),
              ),
            ),
            SizedBox(height: spacing),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: CustomFormTextField(
                hintText: "Password",
                isPassword: true,
                prefixIcon: Icons.lock_outlined,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: horizontalPadding, top: spacing),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Confirm Password',
                  style: Styles.textStyle16.copyWith(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Work Sans',
                    fontSize: fontSize,
                  ),
                ),
              ),
            ),
            SizedBox(height: spacing),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: CustomFormTextField(
                hintText: "Password Again",
                isPassword: true,
                prefixIcon: Icons.lock_outlined,
              ),
            ),

            CustomErrorSnackBar(
              message: "ERROR: Password Doesn't Match!",
              width: snackbarWidth,
              height: snackbarHeight,
            ),
            SizedBox(height: mediumSpacing),
            CustomButton(
              text: 'Sign Up',
              width: buttonWidth,
              height: buttonHeight,
              style: Styles.textStyle16.copyWith(
                fontFamily: 'Work Sans',
                fontSize: fontSize,
              ),
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
            SizedBox(height: mediumSpacing),
            CustomTextSpanWidget(
              text: 'Already have account? ',
              textSpan: 'Sign In',
              route: AppRouter.kSignInView,
            ),
          ],
        ),
      ),
    );
  }
}
