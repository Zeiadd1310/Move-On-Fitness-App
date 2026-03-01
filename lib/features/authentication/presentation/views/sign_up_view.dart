import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_on/core/utils/functions/api_service.dart';
import 'package:move_on/features/authentication/data/repos/auth_repo_impl.dart';
import 'package:move_on/features/authentication/presentation/cubits/sign_up/sign_up_cubit.dart';
import 'package:move_on/features/authentication/presentation/views/widgets/sign_up_view_body.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignUpCubit(AuthRepoImpl(ApiService())),
      child: const Scaffold(body: SignUpViewBody()),
    );
  }
}
