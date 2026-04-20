import 'package:flutter/material.dart';
import 'package:move_on/core/services/local_storage_service.dart';
import 'package:move_on/core/utils/functions/styles.dart';
import 'package:move_on/core/widgets/custom_assessment_text_widget.dart';
import 'package:move_on/features/information/data/models/workout_plan_model.dart';
import 'package:move_on/features/workout/presentation/views/widgets/days_view_body.dart';

class WorkoutPlanView extends StatelessWidget {
  const WorkoutPlanView({super.key, required this.workoutPlan});

  final WorkoutPlan workoutPlan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: DaysViewBody(workoutPlan: workoutPlan));
  }
}

/// Shown when navigating to the workout plan without route `extra` (e.g. from Home).
/// Loads the last plan saved after a successful API generation.
class WorkoutPlanLoaderView extends StatefulWidget {
  const WorkoutPlanLoaderView({super.key});

  @override
  State<WorkoutPlanLoaderView> createState() => _WorkoutPlanLoaderViewState();
}

class _WorkoutPlanLoaderViewState extends State<WorkoutPlanLoaderView> {
  WorkoutPlan? _plan;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final plan = await LocalStorageService().loadWorkoutPlan();
    if (!mounted) return;
    setState(() {
      _plan = plan;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_plan == null) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomAssessmentTextWidget(),
                const Spacer(),
                Text(
                  'No workout plan yet',
                  style: Styles.textStyle24.copyWith(
                    fontFamily: 'Work Sans',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Generate your plan from the assessment first. After that, '
                  'opening Workout from Home will show your saved plan.',
                  style: Styles.textStyle16.copyWith(
                    color: Colors.white70,
                    height: 1.35,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      );
    }

    return WorkoutPlanView(workoutPlan: _plan!);
  }
}
