import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/constants.dart';
import 'package:move_on/core/utils/functions/styles.dart';
import 'package:move_on/core/widgets/custom_background_widget.dart';
import 'package:move_on/core/widgets/custom_error_snackbar.dart';
import 'package:move_on/core/widgets/custom_text_field.dart';
import 'package:move_on/features/authentication/presentation/cubits/forgot_password/forgot_password_cubit.dart';
import 'package:move_on/features/authentication/presentation/views/widgets/reset_option_card.dart';
import 'package:move_on/features/welcome/presentation/views/widgets/custom_back_button.dart';
import 'package:move_on/features/welcome/presentation/views/widgets/custom_button.dart';

class ForgetPasswordViewBody extends StatefulWidget {
  const ForgetPasswordViewBody({super.key});

  @override
  State<ForgetPasswordViewBody> createState() => _ForgetPasswordViewBodyState();
}

class _ForgetPasswordViewBodyState extends State<ForgetPasswordViewBody> {
  final _emailController = TextEditingController();
  String _selectedMethod = 'email';

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
      listener: (context, state) {
        if (state is ForgotPasswordSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message.isNotEmpty
                    ? state.message
                    : 'Reset link sent successfully!',
              ),
              backgroundColor: Colors.green,
            ),
          );
          context.pop();
        } else if (state is ForgotPasswordFailure) {
          CustomErrorSnackBar.show(context, state.errMessage);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
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
                    const SizedBox(height: 30),
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
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        'Select what method you\'d like to reset.',
                        style: Styles.textStyle16.copyWith(
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Work Sans',
                          color: const Color(0xffD7D8D9),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Center(
                      child: SizedBox(
                        width: 380,
                        child: GestureDetector(
                          onTap: () =>
                              setState(() => _selectedMethod = 'email'),
                          child: ResetOptionCard(
                            iconBg: _selectedMethod == 'email'
                                ? kPrimaryColor.withOpacity(0.2)
                                : const Color(0xff24262B),
                            icon: Icons.email,
                            title: 'Send via Email',
                            subtitle:
                                'Seamlessly reset your password via email address.',
                            icColor: kPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: 380,
                        child: GestureDetector(
                          onTap: () =>
                              setState(() => _selectedMethod = 'phone'),
                          child: ResetOptionCard(
                            iconBg: _selectedMethod == 'phone'
                                ? const Color(0xff2563EB).withOpacity(0.2)
                                : const Color(0xff24262B),
                            icon: Icons.phone,
                            title: 'Send via Phone Number',
                            subtitle:
                                'Seamlessly reset your password via 2 Numbers.',
                            icColor: const Color(0xff2563EB),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: CustomFormTextField(
                        prefixIcon: _selectedMethod == 'email'
                            ? Icons.mail_outline
                            : Icons.phone_outlined,
                        hintText: _selectedMethod == 'email'
                            ? 'Email Address'
                            : 'Phone Number',
                        onChanged: (val) => _emailController.text = val,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Align(
                      alignment: Alignment.center,
                      child: state is ForgotPasswordLoading
                          ? const CircularProgressIndicator()
                          : CustomButton(
                              text: 'Reset Password',
                              width: 343,
                              height: 56,
                              style: Styles.textStyle18.copyWith(
                                fontFamily: 'Work Sans',
                                fontWeight: FontWeight.w600,
                              ),
                              radius: 19,
                              onTap: () {
                                if (_emailController.text.trim().isNotEmpty) {
                                  context
                                      .read<ForgotPasswordCubit>()
                                      .forgotPassword(
                                        email: _emailController.text.trim(),
                                      );
                                } else {
                                  CustomErrorSnackBar.show(
                                      context, 'Please enter your email');
                                }
                              },
                            ),
                    ),
                    const SizedBox(height: 300),
                  ],
                ),
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
      },
    );
  }
}
