import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_on/core/services/local_storage_service.dart';
import 'package:move_on/core/utils/functions/api_service.dart';
import 'package:move_on/features/information/data/repos/information_repo_impl.dart';
import 'package:move_on/features/information/presentation/cubits/days_cubit/days_cubit.dart';
import 'package:move_on/features/information/presentation/cubits/generate_workout_plan_cubit/generate_workout_plan_cubit.dart';
import 'package:move_on/features/information/presentation/views/widgets/assessment_three_view_body.dart';

class AssessmentThreeView extends StatelessWidget {
  final int assessmentId;
  final Object? activityLevel;
  final Object? goal;

  const AssessmentThreeView({
    super.key,
    required this.assessmentId,
    required this.activityLevel,
    required this.goal,
  });

  @override
  Widget build(BuildContext context) {
    final parsedActivityLevel = activityLevel is int
        ? activityLevel as int
        : int.tryParse(activityLevel?.toString() ?? '') ?? 0;
    final parsedGoal = goal?.toString() ?? '';

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => DaysCubit()..selectDays(5)),
        BlocProvider(
          create: (_) => GenerateWorkoutPlanCubit(
            InformationRepoImpl(ApiService(), LocalStorageService()),
          ),
        ),
      ],
      child: Scaffold(
        body: AssessmentThreeViewBody(
          assessmentId: assessmentId,
          activityLevel: parsedActivityLevel,
          goal: parsedGoal,
        ),
      ),
    );
  }
}
