import 'package:flutter/material.dart';
import 'package:move_on/constants.dart';
import 'package:move_on/core/utils/functions/styles.dart';

class BodyDataInputWithUnit extends StatelessWidget {
  const BodyDataInputWithUnit({
    super.key,
    required this.controller,
    required this.units,
    required this.selectedUnit,
    required this.onUnitChanged,
    required this.width,
  });

  final TextEditingController controller;
  final List<String> units;
  final String selectedUnit;
  final Function(String) onUnitChanged;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFF2B2E33),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: controller,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                style: Styles.textStyle30.copyWith(
                  fontFamily: 'Work Sans',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            flex: 1,
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFF2B2E33),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: units.map((unit) {
                  final isSelected = unit == selectedUnit;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => onUnitChanged(unit),
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? kPrimaryColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            unit,
                            style: Styles.textStyle14.copyWith(
                              fontFamily: 'Work Sans',
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
