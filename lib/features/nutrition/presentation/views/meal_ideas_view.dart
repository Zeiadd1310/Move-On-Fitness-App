import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_on/core/services/local_storage_service.dart';
import 'package:move_on/core/utils/functions/api_service.dart';
import 'package:move_on/features/nutrition/data/repos/nutrition_repo_impl.dart';
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
    final isFirstTime = await localStorage.isFirstTime();
    setState(() {
      _showIntro = isFirstTime;
      _checked = true;
    });
    if (isFirstTime) {
      await localStorage.setNotFirstTime();
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
    return BlocProvider(
      create: (_) => GenerateNutritionPlanCubit(
        NutritionRepoImpl(ApiService(), LocalStorageService()),
      )..generateNutritionPlan(),
      child: const Scaffold(body: MealIdeasViewBody()),
    );
  }
}
