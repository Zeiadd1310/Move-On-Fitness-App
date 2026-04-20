import 'package:flutter/material.dart';
import 'package:move_on/core/utils/functions/styles.dart';
import 'package:move_on/core/widgets/network_or_asset_image.dart';
import 'package:move_on/features/welcome/presentation/views/widgets/custom_button.dart';

class WorkoutDayCard extends StatelessWidget {
  const WorkoutDayCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.onStart,
  });

  final String title;
  final String subtitle;
  final String imageUrl;
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: SizedBox(
                  height: 175,
                  width: double.infinity,
                  child: imageUrl.isEmpty
                      ? _placeholder()
                      : NetworkOrAssetImage(
                          path: imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => _placeholder(),
                        ),
                ),
              ),
              Positioned(
                left: 12,
                bottom: 10,
                child: Text(
                  '$title\n$subtitle',
                  style: Styles.textStyle18.copyWith(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: const BoxDecoration(
              color: Color(0xFF2B2E33),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Workout Schedule',
                  style: Styles.textStyle16.copyWith(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                CustomButton(
                  text: 'Start Now',
                  width: 128,
                  height: 36,
                  style: Styles.textStyle18.copyWith(
                    fontFamily: 'League Spartan',
                    fontWeight: FontWeight.w500,
                  ),
                  radius: 19,
                  onTap: onStart,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _placeholder() {
    return const DecoratedBox(
      decoration: BoxDecoration(color: Color(0xFF383D44)),
      child: Center(
        child: Icon(Icons.fitness_center, color: Colors.white70, size: 38),
      ),
    );
  }
}
