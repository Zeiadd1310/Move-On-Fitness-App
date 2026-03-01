import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/core/services/local_storage_service.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/core/utils/functions/styles.dart';
import 'package:move_on/core/utils/helpers/responsive_helper.dart';
import 'package:move_on/core/widgets/custom_error_snackbar.dart';
import 'package:move_on/core/widgets/custom_text_field.dart';
import 'package:move_on/features/authentication/presentation/cubits/sign_up/sign_up_cubit.dart';
import 'package:move_on/features/authentication/presentation/views/widgets/custom_signing_view.dart';
import 'package:move_on/features/authentication/presentation/views/widgets/custom_text_span_widget.dart';
import 'package:move_on/features/authentication/presentation/views/widgets/social_icon.dart';
import 'package:move_on/features/welcome/presentation/views/widgets/custom_button.dart';

class SignUpViewBody extends StatefulWidget {
  const SignUpViewBody({super.key});

  @override
  State<SignUpViewBody> createState() => _SignUpViewBodyState();
}

class _SignUpViewBodyState extends State<SignUpViewBody> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);
    final horizontalPadding = responsive.horizontalPadding();
    final spacing = responsive.spacing(10);
    final mediumSpacing = responsive.spacing(30);
    final fontSize = responsive.fontSize(16);
    final buttonWidth = responsive.buttonWidth(360);
    final buttonHeight = responsive.buttonHeight(56);

    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) async {
        if (state is SignUpSuccess) {
          final localStorage = LocalStorageService();
          await localStorage.saveToken(state.token);
          await localStorage.setSignedIn(true);
          if (context.mounted) {
            GoRouter.of(context).push(AppRouter.kBodyDataView);
          }
        } else if (state is SignUpFailure) {
          CustomErrorSnackBar.show(context, state.errMessage);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomSigningView(
                    title: 'Sign Up For Free',
                    subTitle: 'Quickly make your account in 1 minute',
                  ),
                  // Padding(
                  //   padding: EdgeInsets.only(left: horizontalPadding),
                  //   child: Align(
                  //     alignment: Alignment.centerLeft,
                  //     child: Text(
                  //       'Full Name',
                  //       style: Styles.textStyle16.copyWith(
                  //         fontWeight: FontWeight.bold,
                  //         fontFamily: 'Work Sans',
                  //         fontSize: fontSize,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: spacing),
                  // Padding(
                  //   padding:
                  //       EdgeInsets.symmetric(horizontal: horizontalPadding),
                  //   child: CustomFormTextField(
                  //     prefixIcon: Icons.person_outline,
                  //     hintText: 'Full Name',
                  //     onChanged: (val) => _nameController.text = val,
                  //   ),
                  // ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: horizontalPadding,
                      top: spacing,
                    ),
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
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                    ),
                    child: CustomFormTextField(
                      prefixIcon: Icons.mail_outline,
                      hintText: 'Email Address',
                      onChanged: (val) => _emailController.text = val,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: horizontalPadding,
                      top: spacing,
                    ),
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
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                    ),
                    child: CustomFormTextField(
                      hintText: 'Password',
                      isPassword: true,
                      prefixIcon: Icons.lock_outlined,
                      onChanged: (val) => _passwordController.text = val,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: horizontalPadding,
                      top: spacing,
                    ),
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
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                    ),
                    child: CustomFormTextField(
                      hintText: 'Password Again',
                      isPassword: true,
                      prefixIcon: Icons.lock_outlined,
                      onChanged: (val) => _confirmPasswordController.text = val,
                    ),
                  ),
                  SizedBox(height: spacing),
                  state is SignUpLoading
                      ? const CircularProgressIndicator()
                      : CustomButton(
                          text: 'Sign Up',
                          width: buttonWidth,
                          height: buttonHeight,
                          style: Styles.textStyle16.copyWith(
                            fontFamily: 'Work Sans',
                            fontSize: fontSize,
                          ),
                          radius: 19,
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<SignUpCubit>().signUp(
                                name: _nameController.text.trim(),
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                                confirmPassword: _confirmPasswordController.text
                                    .trim(),
                              );
                            }
                          },
                        ),
                  SizedBox(height: mediumSpacing),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialIcon(icon: FontAwesomeIcons.google),
                      const SizedBox(width: 20),
                      SocialIcon(icon: FontAwesomeIcons.facebook),
                    ],
                  ),
                  SizedBox(height: spacing * 1.5),
                  CustomTextSpanWidget(
                    text: 'Already have account? ',
                    textSpan: 'Sign In',
                    route: AppRouter.kSignInView,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
