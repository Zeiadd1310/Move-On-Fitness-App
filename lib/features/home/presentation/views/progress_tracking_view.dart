import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_on/core/utils/functions/api_service.dart';
import 'package:move_on/features/home/data/repos/progress_repo_impl.dart';
import 'package:move_on/features/home/presentation/cubits/progress_cubit/progress_cubit.dart';
import 'package:move_on/features/home/presentation/views/widgets/progress_tracking_view_body.dart';

class ProgressTrackingView extends StatelessWidget {
  const ProgressTrackingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProgressCubit(ProgressRepoImpl(ApiService())),
      child: const Scaffold(body: ProgressTrackingViewBody()),
    );
  }
}
