import 'package:flutter/material.dart';
import 'package:move_on/core/utils/functions/styles.dart';

class ExerciseButton extends StatelessWidget {
  const ExerciseButton({
    super.key,
    required this.exerciseName,
    this.onTap,
    this.imagePath,
  });

  final String exerciseName;
  final VoidCallback? onTap;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF554949),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(8),
              ),
              child: imagePath != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(imagePath!, fit: BoxFit.cover),
                    )
                  : Icon(Icons.fitness_center, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                exerciseName,
                style: Styles.textStyle20.copyWith(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Icon(Icons.arrow_circle_right_outlined, size: 28),
          ],
        ),
      ),
    );
  }
}
