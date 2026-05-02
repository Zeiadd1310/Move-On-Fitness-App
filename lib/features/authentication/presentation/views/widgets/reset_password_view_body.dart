import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/core/utils/functions/styles.dart';
import 'package:move_on/core/widgets/custom_error_snackbar.dart';
import 'package:move_on/core/widgets/custom_text_field.dart';
import 'package:move_on/features/authentication/presentation/cubits/reset_password/reset_password_cubit.dart';
import 'package:move_on/features/welcome/presentation/views/widgets/custom_back_button.dart';
import 'package:move_on/features/welcome/presentation/views/widgets/custom_button.dart';

class ResetPasswordViewBody extends StatefulWidget {
  const ResetPasswordViewBody({
    super.key,
    required this.initialEmail,
    this.initialToken,
    this.forgotPasswordSentMessage,
  });

  final String initialEmail;
  final String? initialToken;
  final String? forgotPasswordSentMessage;

  @override
  State<ResetPasswordViewBody> createState() => _ResetPasswordViewBodyState();
}

class _ResetPasswordViewBodyState extends State<ResetPasswordViewBody> {
  late final TextEditingController _emailController;
  late final TextEditingController _tokenController;
  late final TextEditingController _newPasswordController;
  late final TextEditingController _confirmPasswordController;
  final _formKey = GlobalKey<FormState>();

  /// Token was supplied by the forgot-password API / navigation — no need to show the field.
  bool get _hideTokenField => (widget.initialToken?.trim().isNotEmpty ?? false);

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.initialEmail);
    _tokenController = TextEditingController(text: widget.initialToken ?? '');
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    final ack = widget.forgotPasswordSentMessage?.trim();
    if (ack != null && ack.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(ack), backgroundColor: Colors.green),
        );
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _tokenController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );
          context.go(AppRouter.kSignInView);
        } else if (state is ResetPasswordFailure) {
          CustomErrorSnackBar.show(context, state.errMessage);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 56),
                    CustomBackButton(
                      onTap: () => context.pop(),
                      width: 50,
                      height: 50,
                      radius: 18,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Set new password',
                      style: Styles.textStyle30.copyWith(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Work Sans',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _hideTokenField
                          ? 'Choose a new password for your account.'
                          : 'Paste the reset code from your email, then choose a new password.',
                      style: Styles.textStyle16.copyWith(
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Work Sans',
                        color: const Color(0xffD7D8D9),
                      ),
                    ),
                    const SizedBox(height: 32),
                    CustomFormTextField(
                      hintText: 'Email',
                      prefixIcon: Icons.mail_outline,
                      controller: _emailController,
                      onChanged: (_) {},
                      validator: (data) => data == null || data.trim().isEmpty
                          ? 'Email is required'
                          : null,
                    ),
                    if (!_hideTokenField) ...[
                      const SizedBox(height: 16),
                      CustomFormTextField(
                        hintText: 'Reset code',
                        prefixIcon: Icons.security,
                        controller: _tokenController,
                        onChanged: (_) {},
                        validator: (data) => data == null || data.trim().isEmpty
                            ? 'Reset code is required'
                            : null,
                      ),
                    ],
                    const SizedBox(height: 16),
                    CustomFormTextField(
                      hintText: 'New password',
                      isPassword: true,
                      prefixIcon: Icons.lock_outlined,
                      controller: _newPasswordController,
                      onChanged: (_) {},
                      validator: (data) => data == null || data.isEmpty
                          ? 'Password is required'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    CustomFormTextField(
                      hintText: 'Confirm new password',
                      isPassword: true,
                      prefixIcon: Icons.lock_outlined,
                      controller: _confirmPasswordController,
                      onChanged: (_) {},
                      validator: (data) {
                        if (data == null || data.isEmpty) {
                          return 'Please confirm password';
                        }
                        if (data != _newPasswordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 40),
                    Align(
                      alignment: Alignment.center,
                      child: state is ResetPasswordLoading
                          ? const CircularProgressIndicator()
                          : CustomButton(
                              text: 'Update password',
                              width: 343,
                              height: 56,
                              style: Styles.textStyle18.copyWith(
                                fontFamily: 'Work Sans',
                                fontWeight: FontWeight.w600,
                              ),
                              radius: 19,
                              onTap: () {
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }
                                context
                                    .read<ResetPasswordCubit>()
                                    .resetPassword(
                                      email: _emailController.text.trim(),
                                      token: _tokenController.text.trim(),
                                      newPassword: _newPasswordController.text
                                          .trim(),
                                    );
                              },
                            ),
                    ),
                    const SizedBox(height: 48),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
