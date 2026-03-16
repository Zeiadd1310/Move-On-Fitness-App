import 'package:flutter/material.dart';
import 'package:move_on/constants.dart';
import 'package:move_on/core/utils/functions/styles.dart';

class BodyDataGenderSelector extends StatelessWidget {
  const BodyDataGenderSelector({
    super.key,
    required this.selectedGender,
    required this.onGenderChanged,
    required this.width,
  });

  final String selectedGender;
  final Function(String) onGenderChanged;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: const Color(0xFF2B2E33),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => onGenderChanged('Male'),
                child: Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: selectedGender == 'Male'
                        ? kPrimaryColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Male',
                      style: Styles.textStyle20.copyWith(
                        fontFamily: 'Work Sans',
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => onGenderChanged('Femail'),
                child: Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: selectedGender == 'Femail'
                        ? kPrimaryColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Femail',
                      style: Styles.textStyle20.copyWith(
                        fontFamily: 'Work Sans',
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
