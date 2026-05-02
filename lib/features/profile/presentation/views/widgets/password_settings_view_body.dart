import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/constants.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/core/utils/functions/styles.dart';
import 'package:move_on/core/widgets/custom_assessment_text_widget.dart';
import 'package:move_on/core/widgets/custom_error_snackbar.dart';
import 'package:move_on/core/widgets/custom_text_field.dart';
import 'package:move_on/features/profile/presentation/cubits/change_password_cubit/change_password_cubit.dart';
import 'package:move_on/features/profile/presentation/cubits/change_password_cubit/change_password_state.dart';
import 'package:move_on/features/welcome/presentation/views/widgets/custom_button.dart';

class PasswordSettingsViewBody extends StatefulWidget {
  const PasswordSettingsViewBody({super.key});

  @override
  State<PasswordSettingsViewBody> createState() =>
      _PasswordSettingsViewBodyState();
}

class _PasswordSettingsViewBodyState extends State<PasswordSettingsViewBody> {
  final _currentController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _currentController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
      listener: (context, state) {
        if (state is ChangePasswordSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );
          _currentController.clear();
          _newController.clear();
          _confirmController.clear();
          context.pop();
        } else if (state is ChangePasswordFailure) {
          CustomErrorSnackBar.show(context, state.errMessage);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const CustomAssessmentTextWidget(text: 'Password Settings'),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Current Password',
                            style: Styles.textStyle20.copyWith(
                              fontFamily: 'League Spartan',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 20),
                          CustomFormTextField(
                            hintText: 'Current Password',
                            isPassword: true,
                            controller: _currentController,
                            onChanged: (_) {},
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                GoRouter.of(context)
                                    .push(AppRouter.kForgetPasswordView);
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
                          const SizedBox(height: 50),
                          Text(
                            'New Password',
                            style: Styles.textStyle20.copyWith(
                              fontFamily: 'League Spartan',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 20),
                          CustomFormTextField(
                            hintText: 'New Password',
                            isPassword: true,
                            controller: _newController,
                            onChanged: (_) {},
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Confirm New Password',
                            style: Styles.textStyle20.copyWith(
                              fontFamily: 'League Spartan',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 20),
                          CustomFormTextField(
                            hintText: 'Confirm Password',
                            isPassword: true,
                            controller: _confirmController,
                            onChanged: (_) {},
                            validator: (data) {
                              if (data == null || data.isEmpty) {
                                return 'Please confirm password';
                              }
                              if (data != _newController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                    child: state is ChangePasswordLoading
                        ? const Center(child: CircularProgressIndicator())
                        : CustomButton(
                            text: 'Change Password',
                            width: 220,
                            height: 50,
                            style: Styles.textStyle18.copyWith(
                              fontFamily: 'League Spartan',
                              fontWeight: FontWeight.w500,
                            ),
                            radius: 100,
                            onTap: () {
                              if (!_formKey.currentState!.validate()) return;
                              context.read<ChangePasswordCubit>().changePassword(
                                    currentPassword:
                                        _currentController.text.trim(),
                                    newPassword: _newController.text.trim(),
                                    confirmPassword:
                                        _confirmController.text.trim(),
                                  );
                            },
                          ),
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
