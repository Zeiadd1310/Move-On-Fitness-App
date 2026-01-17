import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/constants.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/features/nutrition/presentation/views/meal_ideas/widgets/meal_tabs.dart';
import 'package:move_on/features/nutrition/presentation/views/meal_ideas/widgets/recipe_image_with_badge.dart';

class RecipeDetailView extends StatefulWidget {
  final Map<String, dynamic>? recipeData;

  const RecipeDetailView({super.key, this.recipeData});

  @override
  State<RecipeDetailView> createState() => _RecipeDetailViewState();
}

class _RecipeDetailViewState extends State<RecipeDetailView> {
  @override
  void initState() {
    super.initState();
  }

  MealType _mealTypeFrom(dynamic v) {
    if (v == null) return MealType.breakfast;
    if (v is MealType) return v;
    final s = v.toString().toLowerCase();
    if (s.contains('lunch')) return MealType.lunch;
    if (s.contains('dinner')) return MealType.dinner;
    return MealType.breakfast;
  }

  @override
  Widget build(BuildContext context) {
    final d = widget.recipeData ?? {};
    final title = d['title'] as String? ?? 'Recipe';
    final time = d['time'] as String? ?? '—';
    final calories = d['calories'] as String? ?? d['cal'] as String? ?? '—';
    final timeStr = time.contains('Minutes') ? time : '$time Minutes';
    final calStr = calories.contains('Cal') ? calories : '$calories Cal';
    final imagePath =
        d['imagePath'] as String? ??
        d['image'] as String? ??
        'assets/images/nutiration meal.png';
    final ingredients =
        (d['ingredients'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        ['—'];
    final preparation = d['preparation'] as String? ?? '—';
    final isRecipeOfTheDay = d['isRecipeOfTheDay'] as bool? ?? false;
    final mealType = _mealTypeFrom(d['mealType']);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header
            SliverToBoxAdapter(child: _buildHeader(context)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                child: MealTabs(initialSelected: mealType, isReadOnly: true),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 20)),
            // Title and time/calories before image
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: kPrimaryColor,
                        fontSize: 22,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time_filled,
                          size: 16,
                          color: kPrimaryColor,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          timeStr,
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'League Spartan',
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Icon(
                          FontAwesomeIcons.fire,
                          size: 16,
                          color: kPrimaryColor,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          calStr,
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'League Spartan',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 16)),
            // Image
            SliverToBoxAdapter(
              child: RecipeImageWithBadge(
                imagePath: imagePath,
                showBadge: isRecipeOfTheDay,
                badgePosition: Alignment.topRight,
                containerHeight: 275,
                imageHeight: 235,
                hasPadding: true,
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 10)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 24,
                  right: 24,
                  top: 16,
                  bottom: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Ingredients
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Ingredients',
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ...ingredients.map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(bottom: 4, left: 24),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '• ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    e,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'League Spartan',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Preparation
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Preparation',
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.only(left: 24.0),
                          child: Text(
                            preparation,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: 'League Spartan',
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final padding = (screenWidth * 0.04).clamp(12.0, 20.0);
    final iconSize = (screenWidth * 0.075).clamp(24.0, 30.0);
    final backIconSize = (screenWidth * 0.0625).clamp(20.0, 28.0);
    final fontSize = (screenWidth * 0.06).clamp(16.0, 24.0);

    return Padding(
      padding: EdgeInsets.all(padding),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: Icon(Icons.arrow_back_ios_new_rounded, size: backIconSize),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Meal Ideas',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () {},
            icon: Icon(Icons.search, color: kPrimaryColor, size: iconSize),
          ),
          const SizedBox(width: 4),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () {
              GoRouter.of(context).push(AppRouter.kNotificationSettingsView);
            },
            icon: Icon(
              Icons.notifications,
              color: kPrimaryColor,
              size: iconSize,
            ),
          ),
          const SizedBox(width: 4),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () {
              GoRouter.of(context).push(AppRouter.kProfileView);
            },
            icon: Icon(Icons.person, color: kPrimaryColor, size: iconSize),
          ),
        ],
      ),
    );
  }
}
