import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_on/core/utils/functions/api_service.dart';
import 'package:move_on/features/authentication/data/repos/auth_repo_impl.dart';
import 'package:move_on/features/authentication/presentation/cubits/reset_password/reset_password_cubit.dart';
import 'package:move_on/features/authentication/presentation/views/widgets/reset_password_view_body.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({
    super.key,
    required this.email,
    this.initialToken,
    this.forgotPasswordSentMessage,
  });

  final String email;
  final String? initialToken;
  final String? forgotPasswordSentMessage;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ResetPasswordCubit(AuthRepoImpl(ApiService())),
      child: ResetPasswordViewBody(
        initialEmail: email,
        initialToken: initialToken,
        forgotPasswordSentMessage: forgotPasswordSentMessage,
      ),
    );
  }
}
