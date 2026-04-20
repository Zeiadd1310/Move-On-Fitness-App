import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/core/widgets/custom_assessment_text_widget.dart';
import 'package:move_on/features/information/data/models/workout_day_model.dart';
import 'package:move_on/features/information/data/models/workout_plan_model.dart';
import 'package:move_on/features/workout/presentation/views/widgets/custom_workout_card.dart';

class DaysViewBody extends StatelessWidget {
  const DaysViewBody({super.key, required this.workoutPlan});

  final WorkoutPlan workoutPlan;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final firstWeek = workoutPlan.weeks.isNotEmpty
        ? workoutPlan.weeks.first
        : null;
    final days = firstWeek?.days ?? const <WorkoutDay>[];

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CustomAssessmentTextWidget(),
              if (days.isEmpty)
                Padding(
                  padding: EdgeInsets.only(top: height * 0.2),
                  child: const Text('No workout days available yet.'),
                )
              else
                ...List.generate(days.length, (index) {
                  final day = days[index];
                  final coverImage = day.coverDisplayPath;

                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: index == days.length - 1 ? 0 : height * 0.03,
                    ),
                    child: CustomWorkoutCard(
                      title: day.dayType,
                      subtitle: 'Day ${index + 1}',
                      imagePath: coverImage,
                      onStart: () {
                        GoRouter.of(
                          context,
                        ).push(AppRouter.kWorkoutDetailsView, extra: day);
                      },
                    ),
                  );
                }),
            ],
          ),
        ),
      ),
    );
  }
}
