import 'package:flutter/material.dart';
import 'package:move_on/constants.dart';

enum MealType { breakfast, lunch, dinner }

class MealTabs extends StatefulWidget {
  final Function(MealType)? onTabChanged;
  final MealType? initialSelected;
  final bool isReadOnly;

  const MealTabs({
    super.key,
    this.onTabChanged,
    this.initialSelected,
    this.isReadOnly = false,
  });

  @override
  State<MealTabs> createState() => _MealTabsState();
}

class _MealTabsState extends State<MealTabs> {
  late MealType _selectedMeal;

  @override
  void initState() {
    super.initState();
    _selectedMeal = widget.initialSelected ?? MealType.breakfast;
  }

  void _selectTab(MealType mealType) {
    if (widget.isReadOnly) return;
    if (_selectedMeal != mealType) {
      setState(() {
        _selectedMeal = mealType;
      });
      widget.onTabChanged?.call(mealType);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _MealTab(
            title: 'Breakfast',
            selected: _selectedMeal == MealType.breakfast,
            onTap: () => _selectTab(MealType.breakfast),
          ),
          _MealTab(
            title: 'Lunch',
            selected: _selectedMeal == MealType.lunch,
            onTap: () => _selectTab(MealType.lunch),
          ),
          _MealTab(
            title: 'Dinner',
            selected: _selectedMeal == MealType.dinner,
            onTap: () => _selectTab(MealType.dinner),
          ),
        ],
      ),
    );
  }
}

class _MealTab extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const _MealTab({
    required this.title,
    this.selected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: selected ? kPrimaryColor : Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: selected ? Colors.black : kPrimaryColor,
              fontWeight: FontWeight.w600,
              fontFamily: 'League Spartan',
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }
}
