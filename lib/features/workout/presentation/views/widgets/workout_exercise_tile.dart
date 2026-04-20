import 'package:flutter/material.dart';
import 'package:move_on/core/utils/functions/styles.dart';

class WorkoutExerciseTile extends StatelessWidget {
  const WorkoutExerciseTile({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.onTap,
  });

  final String name;
  final String imageUrl;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFF554949),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 50,
                height: 50,
                child: imageUrl.isEmpty
                    ? _placeholder()
                    : Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _placeholder(),
                      ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                name,
                style: Styles.textStyle20.copyWith(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Icon(Icons.arrow_circle_right_outlined, size: 28),
          ],
        ),
      ),
    );
  }

  Widget _placeholder() {
    return const DecoratedBox(
      decoration: BoxDecoration(color: Color(0xFF3E434B)),
      child: Icon(Icons.fitness_center, color: Colors.white70),
    );
  }
}
