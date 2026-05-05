import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/core/services/local_storage_service.dart';
import 'package:move_on/core/utils/functions/api_service.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/core/widgets/custom_assessment_text_widget.dart';
import 'package:move_on/core/widgets/custom_error_snackbar.dart';
import 'package:move_on/features/information/data/models/workout_day_model.dart';
import 'package:move_on/features/information/data/models/workout_plan_model.dart';
import 'package:move_on/features/information/data/repos/information_repo_impl.dart';
import 'package:move_on/features/workout/presentation/views/widgets/custom_workout_card.dart';

class DaysViewBody extends StatefulWidget {
  const DaysViewBody({super.key, required this.workoutPlan});

  final WorkoutPlan workoutPlan;

  @override
  State<DaysViewBody> createState() => _DaysViewBodyState();
}

class _DaysViewBodyState extends State<DaysViewBody> {
  bool _updating = false;

  static const _goalOptions = <String>[
    'Lose Weight',
    'Gain Muscle',
    'Gain Muscles and Lose Weight',
  ];

  static String _goalToApiValue(String selected) {
    switch (selected) {
      case 'Lose Weight':
        return 'LoseWeight';
      case 'Gain Muscle':
        return 'GainMuscle';
      case 'Gain Muscles and Lose Weight':
        return 'GainMusclesAndLoseWeight';
      default:
        return 'LoseWeight';
    }
  }

  static const _activityOptions = <String>[
    'Beginner',
    'Intermediate',
    'Advanced',
  ];

  Future<({String goal, int availableDays, int activityLevel})?>
  _askNewPlanInputs() async {
    final storage = LocalStorageService();
    final last = await storage.loadWorkoutPlanInputs();
    if (!mounted) return null;

    String goalLabel = () {
      final g = last?.goal ?? '';
      if (g.toLowerCase().contains('gainmusclesandloseweight')) {
        return 'Gain Muscles and Lose Weight';
      }
      if (g.toLowerCase().contains('gainmuscle')) return 'Gain Muscle';
      return 'Lose Weight';
    }();
    int days = (last?.availableDays ?? 3).clamp(1, 5);
    int activityLevel = (last?.activityLevel ?? 1).clamp(0, 2);

    return showDialog<({String goal, int availableDays, int activityLevel})?>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setLocal) {
          return AlertDialog(
            backgroundColor: const Color(0xFF2C2C2C),
            title: const Text(
              'Update workout plan',
              style: TextStyle(color: Colors.white),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Goal',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  initialValue: goalLabel,
                  dropdownColor: const Color(0xFF2C2C2C),
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color(0xFF1F1F1F),
                    border: OutlineInputBorder(),
                  ),
                  items: _goalOptions
                      .map(
                        (g) => DropdownMenuItem(
                          value: g,
                          child: Text(g),
                        ),
                      )
                      .toList(),
                  onChanged: (v) => setLocal(() => goalLabel = v ?? goalLabel),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Available days / week',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 6),
                DropdownButtonFormField<int>(
                  initialValue: days,
                  dropdownColor: const Color(0xFF2C2C2C),
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color(0xFF1F1F1F),
                    border: OutlineInputBorder(),
                  ),
                  items: List.generate(
                    5,
                    (i) => DropdownMenuItem(
                      value: i + 1,
                      child: Text('${i + 1}'),
                    ),
                  ),
                  onChanged: (v) => setLocal(() => days = v ?? days),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Activity level',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  initialValue: _activityOptions[activityLevel],
                  dropdownColor: const Color(0xFF2C2C2C),
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color(0xFF1F1F1F),
                    border: OutlineInputBorder(),
                  ),
                  items: _activityOptions
                      .map(
                        (a) => DropdownMenuItem(
                          value: a,
                          child: Text(a),
                        ),
                      )
                      .toList(),
                  onChanged: (v) => setLocal(() {
                    final idx = _activityOptions.indexOf(v ?? '');
                    activityLevel = idx >= 0 ? idx : activityLevel;
                  }),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, null),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(
                    ctx,
                    (
                      goal: _goalToApiValue(goalLabel),
                      availableDays: days,
                      activityLevel: activityLevel,
                    ),
                  );
                },
                child: const Text('Update'),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _onRefreshPressed() async {
    if (_updating) return;

    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF2C2C2C),
        title: const Text(
          'Update workout plan?',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Are you sure you want to update your workout plan?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Yes'),
          ),
        ],
      ),
    );

    if (ok != true || !mounted) return;

    final picked = await _askNewPlanInputs();
    if (picked == null || !mounted) return;

    setState(() => _updating = true);
    try {
      final storage = LocalStorageService();
      await storage.saveWorkoutPlanInputs(
        goal: picked.goal,
        availableDays: picked.availableDays,
        activityLevel: picked.activityLevel,
      );

      final repo = InformationRepoImpl(ApiService(), storage);
      final result = await repo.updateWorkoutPlan(
        goal: picked.goal,
        availableDays: picked.availableDays,
        activityLevel: picked.activityLevel,
      );

      if (!mounted) return;
      result.fold(
        (failure) => CustomErrorSnackBar.show(context, failure.errMessage),
        (plan) {
          if (!mounted) return;
          GoRouter.of(context).pushReplacement(
            AppRouter.kWorkoutPlanView,
            extra: plan,
          );
        },
      );
    } finally {
      if (mounted) setState(() => _updating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final firstWeek = widget.workoutPlan.weeks.isNotEmpty
        ? widget.workoutPlan.weeks.first
        : null;
    final days = firstWeek?.days ?? const <WorkoutDay>[];

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomAssessmentTextWidget(),
                    IconButton(
                      onPressed: _updating ? null : _onRefreshPressed,
                      icon: _updating
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(
                              FontAwesomeIcons.arrowsRotate,
                              color: Colors.white,
                            ),
                    ),
                  ],
                ),
              ),
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
