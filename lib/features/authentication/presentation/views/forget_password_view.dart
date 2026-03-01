import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_on/core/utils/functions/api_service.dart';
import 'package:move_on/features/authentication/data/repos/auth_repo_impl.dart';
import 'package:move_on/features/authentication/presentation/cubits/forgot_password/forgot_password_cubit.dart';
import 'package:move_on/features/authentication/presentation/views/widgets/forget_password_view_body.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ForgotPasswordCubit(AuthRepoImpl(ApiService())),
      child: const Scaffold(body: ForgetPasswordViewBody()),
    );
  }
}
