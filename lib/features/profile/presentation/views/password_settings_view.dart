import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_on/core/utils/functions/api_service.dart';
import 'package:move_on/features/authentication/data/repos/auth_repo_impl.dart';
import 'package:move_on/features/profile/presentation/cubits/change_password_cubit/change_password_cubit.dart';
import 'package:move_on/features/profile/presentation/views/widgets/password_settings_view_body.dart';

class PasswordSettingsView extends StatelessWidget {
  const PasswordSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChangePasswordCubit(AuthRepoImpl(ApiService())),
      child: const Scaffold(body: PasswordSettingsViewBody()),
    );
  }
}
