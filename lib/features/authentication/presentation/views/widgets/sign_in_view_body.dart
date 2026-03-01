import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/core/services/local_storage_service.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/core/utils/functions/styles.dart';
import 'package:move_on/core/widgets/custom_error_snackbar.dart';
import 'package:move_on/core/widgets/custom_text_field.dart';
import 'package:move_on/features/authentication/presentation/cubits/sign_in/sign_in_cubit.dart';
import 'package:move_on/features/authentication/presentation/views/widgets/custom_signing_view.dart';
import 'package:move_on/features/authentication/presentation/views/widgets/custom_text_span_widget.dart';
import 'package:move_on/features/authentication/presentation/views/widgets/social_icon.dart';
import 'package:move_on/features/welcome/presentation/views/widgets/custom_button.dart';

class SignInViewBody extends StatefulWidget {
  const SignInViewBody({super.key});

  @override
  State<SignInViewBody> createState() => _SignInViewBodyState();
}

class _SignInViewBodyState extends State<SignInViewBody> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInCubit, SignInState>(
      listener: (context, state) async {
        if (state is SignInSuccess) {
          final localStorage = LocalStorageService();
          await localStorage.saveToken(state.token);
          await localStorage.setSignedIn(true);
          if (context.mounted) {
            GoRouter.of(context).pushReplacement(AppRouter.kHomeView);
          }
        } else if (state is SignInFailure) {
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
                    title: 'Sign In To Move On',
                    subTitle: 'Let\'s personalize your fitness with AI',
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
                  const SizedBox(height: 10),
                  CustomFormTextField(
                    prefixIcon: Icons.mail_outline,
                    hintText: 'Email Address',
                    onChanged: (val) => _emailController.text = val,
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
                  const SizedBox(height: 10),
                  CustomFormTextField(
                    hintText: 'Password',
                    isPassword: true,
                    prefixIcon: Icons.lock_outlined,
                    onChanged: (val) => _passwordController.text = val,
                  ),
                  const SizedBox(height: 10),
                  state is SignInLoading
                      ? const CircularProgressIndicator()
                      : CustomButton(
                          text: 'Sign In',
                          width: 360,
                          height: 56,
                          style: Styles.textStyle16.copyWith(
                            fontFamily: 'Work Sans',
                          ),
                          radius: 19,
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<SignInCubit>().signIn(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              );
                            }
                          },
                        ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialIcon(icon: FontAwesomeIcons.google),
                      const SizedBox(width: 20),
                      SocialIcon(icon: FontAwesomeIcons.facebook),
                    ],
                  ),
                  const SizedBox(height: 40),
                  CustomTextSpanWidget(
                    text: 'Don\'t have an account? ',
                    textSpan: 'Sign Up',
                    route: AppRouter.kSignUpView,
                  ),
                  const SizedBox(height: 10),
                  CustomTextSpanWidget(
                    text: '',
                    textSpan: 'Forget Password',
                    route: AppRouter.kForgetPasswordView,
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
