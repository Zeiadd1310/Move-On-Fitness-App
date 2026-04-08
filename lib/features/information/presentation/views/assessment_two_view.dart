import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_on/features/information/presentation/cubits/goal_cubit/goal_cubit.dart';
import 'package:move_on/features/information/presentation/views/widgets/assessment_two_view_body.dart';

class AssessmentTwoView extends StatelessWidget {
  final int assessmentId;
  final Object? activityLevel;

  const AssessmentTwoView({
    super.key,
    required this.assessmentId,
    required this.activityLevel,
  });

  @override
  Widget build(BuildContext context) {
    final parsedActivityLevel = activityLevel is int
        ? activityLevel as int
        : int.tryParse(activityLevel?.toString() ?? '') ?? 0;

    return BlocProvider(
      create: (_) => GoalCubit(),
      child: Scaffold(
        body: AssessmentTwoViewBody(
          assessmentId: assessmentId,
          activityLevel: parsedActivityLevel,
        ),
      ),
    );
  }
}
