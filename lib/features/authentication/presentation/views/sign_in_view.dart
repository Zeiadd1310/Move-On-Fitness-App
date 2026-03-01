import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_on/core/utils/functions/api_service.dart';
import 'package:move_on/features/authentication/data/repos/auth_repo_impl.dart';
import 'package:move_on/features/authentication/presentation/cubits/sign_in/sign_in_cubit.dart';
import 'package:move_on/features/authentication/presentation/views/widgets/sign_in_view_body.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignInCubit(AuthRepoImpl(ApiService())),
      child: const Scaffold(body: SignInViewBody()),
    );
  }
}
