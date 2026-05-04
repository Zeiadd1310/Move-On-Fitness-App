import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/constants.dart';
import 'package:move_on/core/services/local_storage_service.dart';
import 'package:move_on/core/utils/functions/api_service.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/core/utils/functions/styles.dart';
import 'package:move_on/features/information/data/models/workout_day_model.dart';
import 'package:move_on/features/information/data/models/workout_excersice_model.dart';
import 'package:move_on/features/information/data/models/workout_plan_model.dart';
import 'package:move_on/features/home/presentation/views/widgets/bottom_workout_card.dart';
import 'package:move_on/features/home/presentation/views/widgets/custom_workout_card_widget.dart';
import 'package:move_on/features/home/presentation/views/widgets/home_menu_item.dart';
import 'package:move_on/features/profile/data/models/user_profile_model.dart';
import 'package:move_on/features/profile/data/repos/profile_repo_impl.dart';
import 'package:move_on/features/profile/presentation/views/widgets/profile_vertical_divider.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  String _greetingName = 'Athlete';

  static const String _cardioFallbackImage = 'assets/images/home3.png';

  static bool _looksCardio(
    String muscleGroup,
    String exerciseType,
    String exerciseName,
  ) {
    final mg = muscleGroup.toLowerCase();
    final et = exerciseType.toLowerCase();
    final n = exerciseName.toLowerCase();
    if (mg.contains('cardio') || et.contains('cardio')) return true;
    return n.contains('cardio') ||
        n.contains('aerobic') ||
        n.contains('treadmill') ||
        n.contains('elliptical') ||
        n.contains('rowing machine') ||
        n.contains('bike') ||
        n.contains('cycling') ||
        n.contains('run ') ||
        n.startsWith('run') ||
        n.contains('running') ||
        n.contains('jog') ||
        n.contains('sprint') ||
        n.contains('walk') ||
        n.contains('jump rope') ||
        n.contains('skipping') ||
        n.contains('burpee') ||
        n.contains('hiit') ||
        n.contains('stair') ||
        n.contains('swim');
  }

  static String _warmupTagLine(String warmupName) {
    final n = warmupName.toLowerCase();
    if (n.contains('cardio') || n.contains('aerobic')) return 'Cardio';
    return 'Warm-up';
  }

  static String _exerciseDurationLine(WorkoutExercise e) {
    final d = e.duration.trim();
    if (d.isNotEmpty) return d;
    final r = e.reps.trim();
    if (r.isNotEmpty) return r;
    return '${e.sets} sets';
  }

  static String _exerciseCaloriesLine(WorkoutExercise e) {
    final c = e.calories;
    if (c > 0) {
      return '${c.toStringAsFixed(c % 1 == 0 ? 0 : 1)} kcal';
    }
    return 'Cardio';
  }

  static List<_HomeRecommendation> _pickCardioRecommendations(
    WorkoutPlan plan,
  ) {
    if (plan.weeks.isEmpty) return const [];
    final week = plan.weeks.first;
    final allExercises = week.days.expand((d) => d.exercises).toList();

    final out = <_HomeRecommendation>[];

    void tryAdd(String title, String imagePath, String sub1, String sub2) {
      if (out.length >= 2) return;
      final t = title.trim();
      if (t.isEmpty) return;
      if (out.any((x) => x.title.trim().toLowerCase() == t.toLowerCase())) {
        return;
      }
      out.add(
        _HomeRecommendation(
          title: t,
          imagePath: imagePath.trim().isNotEmpty
              ? imagePath.trim()
              : _cardioFallbackImage,
          subTitle1: sub1,
          subTitle2: sub2,
        ),
      );
    }

    for (final e in allExercises) {
      if (!_looksCardio(e.muscleGroup, e.exerciseType, e.exerciseName)) {
        continue;
      }
      if (e.exerciseName.trim().isEmpty) continue;
      final img = e.imageUrl.trim().isNotEmpty
          ? e.imageUrl.trim()
          : _cardioFallbackImage;
      tryAdd(
        e.exerciseName,
        img,
        _exerciseDurationLine(e),
        _exerciseCaloriesLine(e),
      );
    }

    for (final w in week.warmup) {
      final name = w.name.trim();
      if (name.isEmpty) continue;
      tryAdd(
        name,
        _cardioFallbackImage,
        w.duration.trim().isNotEmpty ? w.duration.trim() : 'Warm-up',
        _warmupTagLine(name),
      );
    }

    return out;
  }

  static int _parseMinutesLoose(String raw) {
    final m = RegExp(
      r'(\d+)\s*min',
      caseSensitive: false,
    ).firstMatch(raw.trim());
    if (m == null) return 0;
    return int.tryParse(m.group(1) ?? '') ?? 0;
  }

  static String _bottomDayWorkoutsLine(WorkoutDay day) {
    final n = day.exercises.length;
    if (n == 1) return '1 Workout';
    return '$n Workouts';
  }

  static String _bottomDayDurationLine(WorkoutDay day) {
    var minutes = 0;
    for (final e in day.exercises) {
      minutes += _parseMinutesLoose(e.duration);
    }
    if (minutes <= 0) {
      minutes = (day.exercises.length * 8).clamp(25, 90);
    }
    return 'Duration\n$minutes Mins';
  }

  static IconData _bottomDayIcon(WorkoutDay day) {
    final t = day.dayType.toLowerCase();
    if (t.contains('leg')) return Icons.directions_run;
    if (t.contains('pull')) return Icons.fitness_center;
    if (t.contains('push')) return Icons.fitness_center;
    if (t.contains('cardio')) return Icons.directions_run;
    return Icons.fitness_center;
  }

  @override
  void initState() {
    super.initState();
    _loadGreetingName();
  }

  Future<void> _loadGreetingName() async {
    final localStorage = LocalStorageService();
    final cached = await localStorage.loadCachedUserProfile();
    if (cached != null) {
      final profile = UserProfileModel.fromJson(cached);
      if (profile.firstName.isNotEmpty && mounted) {
        setState(() => _greetingName = profile.firstName);
      }
    }

    final repo = ProfileRepoImpl(
      apiService: ApiService(),
      localStorageService: localStorage,
    );
    try {
      final profile = await repo.getMyProfile();
      if (!mounted) return;
      if (profile.firstName.isNotEmpty) {
        setState(() => _greetingName = profile.firstName);
      }
    } catch (e) {
      log("Error loading profile: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 400;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.045,
              vertical: screenHeight * 0.02,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi, $_greetingName',
                          style: Styles.textStyle20.copyWith(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            color: kPrimaryColor,
                          ),
                        ),
                        Text(
                          'It\'s time to challenge your limits.',
                          style: Styles.textStyle14.copyWith(
                            fontFamily: 'League Spartan',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            GoRouter.of(
                              context,
                            ).push(AppRouter.kNotificationSettingsView);
                          },
                          icon: const Icon(
                            Icons.notifications,
                            color: kPrimaryColor,
                            size: 30,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            GoRouter.of(context).push(AppRouter.kProfileView);
                          },
                          icon: const Icon(
                            Icons.person,
                            color: kPrimaryColor,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HomeMenuItem(
                      icon: Icons.fitness_center,
                      title: 'Workout',
                      onTap: () {
                        GoRouter.of(context).push(AppRouter.kWorkoutPlanView);
                      },
                    ),
                    ProfileVerticalDivider(
                      color: kPrimaryColor,
                      height: 50,
                      width: 2,
                    ),
                    HomeMenuItem(
                      icon: FontAwesomeIcons.clipboardCheck,
                      title: 'Progress\nTracking',
                      onTap: () {
                        GoRouter.of(
                          context,
                        ).push(AppRouter.kProgressTrackingView);
                      },
                    ),
                    ProfileVerticalDivider(
                      color: kPrimaryColor,
                      height: 50,
                      width: 2,
                    ),
                    HomeMenuItem(
                      icon: FontAwesomeIcons.appleWhole,
                      title: 'Nutrition',
                      onTap: () {
                        GoRouter.of(
                          context,
                        ).push(AppRouter.kNutritionGetStartedView);
                      },
                    ),
                    ProfileVerticalDivider(
                      color: kPrimaryColor,
                      height: 50,
                      width: 2,
                    ),
                    HomeMenuItem(
                      icon: FontAwesomeIcons.robot,
                      title: 'AI Chat',
                      onTap: () {
                        GoRouter.of(context).push(AppRouter.kChatBotView);
                      },
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  'Recommendations',
                  style: Styles.textStyle20.copyWith(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    color: kPrimaryColor,
                    fontSize: isSmallScreen ? 18 : 20,
                  ),
                ),
                SizedBox(height: screenHeight * 0.012),
                FutureBuilder<WorkoutPlan?>(
                  future: LocalStorageService().loadWorkoutPlan(),
                  builder: (context, snap) {
                    final plan = snap.data;
                    final items = plan == null
                        ? const <_HomeRecommendation>[]
                        : _pickCardioRecommendations(plan);
                    if (items.isEmpty) {
                      return Container(
                        height: isSmallScreen ? 120 : 140,
                        alignment: Alignment.center,
                        child: Text(
                          'No recommendations yet.\nGenerate your workout plan first.',
                          textAlign: TextAlign.center,
                          style: Styles.textStyle16.copyWith(
                            color: Colors.white70,
                            fontFamily: 'Work Sans',
                          ),
                        ),
                      );
                    }

                    return SizedBox(
                      height: isSmallScreen ? 200 : 220,
                      child: isSmallScreen
                          ? Row(
                              children: [
                                CustomWorkoutCardWidget(
                                  title: items[0].title,
                                  imagePath: 'assets/images/joint.png',
                                  subTitle1: items[0].subTitle1,
                                  subTitle2: items[0].subTitle2,
                                  cardWidth: screenWidth * 0.42,
                                ),
                                SizedBox(width: screenWidth * 0.07),
                                CustomWorkoutCardWidget(
                                  title: items.length > 1
                                      ? items[1].title
                                      : items[0].title,
                                  imagePath: items.length > 1
                                      ? 'assets/images/cardio.png'
                                      : items[0].imagePath,
                                  subTitle1: items.length > 1
                                      ? items[1].subTitle1
                                      : items[0].subTitle1,
                                  subTitle2: items.length > 1
                                      ? items[1].subTitle2
                                      : items[0].subTitle2,
                                  cardWidth: screenWidth * 0.42,
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: CustomWorkoutCardWidget(
                                    title: items[0].title,
                                    imagePath: 'assets/images/joint.png',
                                    subTitle1: items[0].subTitle1,
                                    subTitle2: items[0].subTitle2,
                                    cardWidth: null,
                                  ),
                                ),
                                SizedBox(width: screenWidth * 0.04),
                                Expanded(
                                  child: CustomWorkoutCardWidget(
                                    title: items.length > 1
                                        ? items[1].title
                                        : items[0].title,
                                    imagePath: items.length > 1
                                        ? 'assets/images/cardio.png'
                                        : items[0].imagePath,
                                    subTitle1: items.length > 1
                                        ? items[1].subTitle1
                                        : items[0].subTitle1,
                                    subTitle2: items.length > 1
                                        ? items[1].subTitle2
                                        : items[0].subTitle2,
                                    cardWidth: null,
                                  ),
                                ),
                              ],
                            ),
                    );
                  },
                ),
                SizedBox(height: screenHeight * 0.04),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: EdgeInsets.all(screenWidth * 0.025),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(13),
                    ),
                    padding: EdgeInsets.all(screenWidth * 0.04),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            'If when you look in the mirror you don\'t see the perfect version of yourself, you better see the hardest working version of yourself.',
                            style: Styles.textStyle14.copyWith(
                              color: kPrimaryColor,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              fontSize: isSmallScreen ? 12 : 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.012),
                        Expanded(
                          flex: 1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              'assets/images/home3.png',
                              fit: BoxFit.cover,
                              height: isSmallScreen ? 100 : 120,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                FutureBuilder<WorkoutPlan?>(
                  future: LocalStorageService().loadWorkoutPlan(),
                  builder: (context, snap) {
                    final plan = snap.data;
                    final days = plan != null && plan.weeks.isNotEmpty
                        ? plan.weeks.first.days
                        : const <WorkoutDay>[];
                    final d0 = days.isNotEmpty ? days.first : null;
                    final d1 = days.length > 1 ? days[1] : d0;

                    Widget cardFor(WorkoutDay? d) {
                      if (d == null) {
                        return BottomWorkoutCard(
                          icon: Icons.fitness_center,
                          workoutCount: '0 Workouts',
                          duration: 'Duration\n—',
                          workoutType: 'Generate your workout plan',
                        );
                      }
                      return BottomWorkoutCard(
                        icon: _bottomDayIcon(d),
                        workoutCount: _bottomDayWorkoutsLine(d),
                        duration: _bottomDayDurationLine(d),
                        workoutType: d.dayType.trim().isNotEmpty
                            ? d.dayType.trim()
                            : d.dayKey,
                      );
                    }

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: cardFor(d0)),
                        SizedBox(width: screenWidth * 0.04),
                        Expanded(child: cardFor(d1)),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HomeRecommendation {
  final String title;
  final String imagePath;
  final String subTitle1;
  final String subTitle2;

  const _HomeRecommendation({
    required this.title,
    required this.imagePath,
    required this.subTitle1,
    required this.subTitle2,
  });
}
