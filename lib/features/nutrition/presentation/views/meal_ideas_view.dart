import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_on/core/services/local_storage_service.dart';
import 'package:move_on/core/utils/functions/api_service.dart';
import 'package:move_on/features/nutrition/data/repos/nutrition_repo_impl.dart';
import 'package:move_on/features/nutrition/presentation/cubits/food_scan_cubit/food_scan_cubit.dart';
import 'package:move_on/features/nutrition/presentation/cubits/generate_nutrition_plan_cubit/generate_nutrition_plan_cubit.dart';
import 'package:move_on/features/nutrition/presentation/views/meal_ideas/widgets/meal_ideas_view_body.dart';
import 'package:move_on/features/nutrition/presentation/views/nutrition_get_started_view.dart';

class MealIdeasView extends StatefulWidget {
  const MealIdeasView({super.key});

  @override
  State<MealIdeasView> createState() => _MealIdeasViewState();
}

class _MealIdeasViewState extends State<MealIdeasView> {
  bool _showIntro = false;
  bool _checked = false;

  @override
  void initState() {
    super.initState();
    _checkFirstTime();
  }

  Future<void> _checkFirstTime() async {
    final localStorage = LocalStorageService();
    final hasSeen = await localStorage.hasSeenNutritionIntro();
    setState(() {
      _showIntro = !hasSeen;
      _checked = true;
    });
    if (!hasSeen) {
      await localStorage.setNutritionIntroSeen(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_checked) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (_showIntro) {
      return const NutritionGetStartedView();
    }
    final repo = NutritionRepoImpl(ApiService(), LocalStorageService());
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              GenerateNutritionPlanCubit(repo)..loadOrGenerateNutritionPlan(),
        ),
        BlocProvider(create: (_) => FoodScanCubit(repo)),
      ],
      child: const Scaffold(body: MealIdeasViewBody()),
    );
  }
}
