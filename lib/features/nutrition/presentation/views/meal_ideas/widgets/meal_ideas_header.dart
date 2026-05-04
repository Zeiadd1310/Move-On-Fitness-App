import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:move_on/constants.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/features/nutrition/presentation/cubits/food_scan_cubit/food_scan_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MealIdeasHeader extends StatelessWidget {
  const MealIdeasHeader({super.key});

  Future<void> _pickAndScanFood(BuildContext context) async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: const Color(0xFF1A1A1A),
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera, color: kPrimaryColor),
              title: const Text(
                'Take photo',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () => Navigator.of(context).pop(ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: kPrimaryColor),
              title: const Text(
                'Choose from gallery',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () => Navigator.of(context).pop(ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
    if (source == null) return;

    final picker = ImagePicker();
    final picked = await picker.pickImage(source: source, imageQuality: 92);
    if (picked == null || !context.mounted) return;

    context.read<FoodScanCubit>().analyzeImage(imagePath: picked.path);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive sizing based on screen width
    final padding = screenWidth * 0.04; // 4% of screen width
    final iconSize = screenWidth * 0.075; // 7.5% of screen width
    final backIconSize = screenWidth * 0.0625; // 6.25% of screen width
    final fontSize = screenWidth * 0.06; // 6% of screen width
    final spacing = screenWidth * 0.01; // 1% of screen width

    // Clamp values for better UX on very small/large screens
    final clampedPadding = padding.clamp(12.0, 20.0);
    final clampedIconSize = iconSize.clamp(24.0, 30.0);
    final clampedBackIconSize = backIconSize.clamp(20.0, 28.0);
    final clampedFontSize = fontSize.clamp(16.0, 24.0);
    final clampedSpacing = spacing.clamp(0.0, 6.0);

    return Padding(
      padding: EdgeInsets.all(clampedPadding),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              context.pop();
            },
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: clampedBackIconSize,
            ),
          ),
          SizedBox(width: clampedSpacing),
          Expanded(
            child: Text(
              'Meal Ideas',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: clampedFontSize,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          SizedBox(width: clampedSpacing),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            onPressed: () {
              _pickAndScanFood(context);
            },
            icon: Icon(
              FontAwesomeIcons.camera,
              color: kPrimaryColor,
              size: clampedIconSize,
            ),
          ),
          SizedBox(width: clampedSpacing),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            onPressed: () {
              GoRouter.of(context).push(AppRouter.kNotificationSettingsView);
            },
            icon: Icon(
              Icons.notifications,
              color: kPrimaryColor,
              size: clampedIconSize,
            ),
          ),
          SizedBox(width: clampedSpacing),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            onPressed: () {
              GoRouter.of(context).push(AppRouter.kProfileView);
            },
            icon: Icon(
              Icons.person,
              color: kPrimaryColor,
              size: clampedIconSize,
            ),
          ),
        ],
      ),
    );
  }
}
