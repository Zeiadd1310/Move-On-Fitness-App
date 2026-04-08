import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_on/features/information/presentation/cubits/activity_level_cubit/activity_level_cubit.dart';
import 'package:move_on/features/information/presentation/views/widgets/assessment_one_view_body.dart';

class AssessmentOneView extends StatelessWidget {
  final int assessmentId;

  const AssessmentOneView({super.key, required this.assessmentId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ActivityLevelCubit(),
      child: Scaffold(body: AssessmentOneViewBody(assessmentId: assessmentId)),
    );
  }
}
