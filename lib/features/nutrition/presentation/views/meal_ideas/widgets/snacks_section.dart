import 'package:flutter/material.dart';
import 'package:move_on/constants.dart';
import 'package:move_on/features/nutrition/data/models/meals_model/snacks.dart';

class SnacksSection extends StatelessWidget {
  final Snacks? snacks;
  const SnacksSection({Key? key, this.snacks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (snacks == null &&
        (snacks!.meal == null && snacks!.description == null)) {
      return const SizedBox.shrink();
    }

    final mealName = snacks!.meal?.isNotEmpty == true
        ? snacks!.meal!.join(', ')
        : 'Snack';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Snacks',
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: 22,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _SnackCard(snacks: snacks!, mealName: mealName),
        ],
      ),
    );
  }
}

class _SnackCard extends StatelessWidget {
  final Snacks snacks;
  final String mealName;

  const _SnackCard({required this.snacks, required this.mealName});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xFF1E1E2E),
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          if (snacks.image != null && snacks.image!.isNotEmpty)
            Image.network(
              snacks.image!,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _PlaceholderImage(),
            )
          else
            _PlaceholderImage(),

          // Dark gradient overlay
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Color(0xCC000000)],
                stops: [0.4, 1.0],
              ),
            ),
          ),

          // Content at bottom
          Positioned(
            left: 12,
            right: 12,
            bottom: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mealName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Column(
                  children: [
                    Row(
                      children: [
                        if (snacks.quantity != null) ...[
                          const Icon(
                            Icons.restaurant_menu,
                            color: kPrimaryColor,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            snacks.quantity!,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(width: 12),
                        ],
                        if (snacks.calories != null) ...[
                          const Icon(
                            Icons.local_fire_department,
                            color: kPrimaryColor,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${snacks.calories} Cal',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(width: 12),
                        ],
                      ],
                    ),

                    if (snacks.description != null &&
                        snacks.description!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        snacks.description!,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    SizedBox(height: 4),
                    if (snacks.protein != null) ...[
                      Row(
                        children: [
                          const Icon(
                            Icons.fitness_center,
                            color: kPrimaryColor,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${snacks.protein}g Protein',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PlaceholderImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF2A2A3E),
      child: const Center(
        child: Icon(Icons.fastfood, color: Colors.white24, size: 60),
      ),
    );
  }
}
