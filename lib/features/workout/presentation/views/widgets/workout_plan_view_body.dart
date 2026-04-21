import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/core/widgets/custom_assessment_text_widget.dart';
import 'package:move_on/features/information/data/models/workout_day_model.dart';
import 'package:move_on/features/information/data/models/workout_plan_model.dart';
import 'package:move_on/features/workout/presentation/views/widgets/workout_day_card.dart';

class WorkoutPlanViewBody extends StatelessWidget {
  const WorkoutPlanViewBody({super.key, required this.workoutPlan});

  final WorkoutPlan workoutPlan;

  @override
  Widget build(BuildContext context) {
    final firstWeek = workoutPlan.weeks.isNotEmpty
        ? workoutPlan.weeks.first
        : null;
    final days = firstWeek?.days ?? const <WorkoutDay>[];

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            const CustomAssessmentTextWidget(),
            Expanded(
              child: days.isEmpty
                  ? const Center(child: Text('No workout days available yet.'))
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 2,
                      ),
                      itemBuilder: (context, index) {
                        final day = days[index];
                        return WorkoutDayCard(
                          title: day.dayType,
                          subtitle: day.dayKey.replaceAll('day', 'Day_'),
                          imageUrl: day.coverDisplayPath,
                          onStart: () => GoRouter.of(
                            context,
                          ).push(AppRouter.kWorkoutDetailsView, extra: day),
                        );
                      },
                      separatorBuilder: (_, __) => const SizedBox(height: 14),
                      itemCount: days.length,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
