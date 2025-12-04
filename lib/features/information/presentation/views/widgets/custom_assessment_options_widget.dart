import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/core/utils/functions/styles.dart';
import 'package:move_on/features/welcome/presentation/views/widgets/custom_button.dart';

class CustomAssessmentOptionsWidget extends StatefulWidget {
  const CustomAssessmentOptionsWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.options,
    this.initialSelectedIndex = -1,
    this.onChanged,
    this.onContinue,
    this.continueText = 'Continue',
    this.nextRoute,
  });

  final String title;
  final String subtitle;
  final List<String> options;
  final int initialSelectedIndex;
  final ValueChanged<int>? onChanged;
  final VoidCallback? onContinue;
  final String continueText;
  final String? nextRoute;

  @override
  State<CustomAssessmentOptionsWidget> createState() =>
      _CustomAssessmentOptionsWidgetState();
}

class _CustomAssessmentOptionsWidgetState
    extends State<CustomAssessmentOptionsWidget> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialSelectedIndex;
    if (_selectedIndex < 0 || _selectedIndex >= widget.options.length) {
      _selectedIndex = -1; // no selection
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            widget.title,
            textAlign: TextAlign.center,
            style: Styles.textStyle30.copyWith(fontFamily: 'Work Sans'),
          ),
        ),
        SizedBox(height: height * 0.05),
        Center(
          child: Text(
            widget.subtitle,
            textAlign: TextAlign.center,
            style: Styles.textStyle16.copyWith(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        SizedBox(height: height * 0.06),
        Expanded(
          child: ListView.separated(
            itemCount: widget.options.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final isSelected = index == _selectedIndex;
              return GestureDetector(
                onTap: () {
                  setState(() => _selectedIndex = index);
                  widget.onChanged?.call(index);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 18,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xff34373F)
                        : const Color(0xff25282F),
                    borderRadius: BorderRadius.circular(19),
                    border: Border.all(
                      color: isSelected ? Colors.white38 : Colors.transparent,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.options[index],
                        style: Styles.textStyle18.copyWith(
                          fontFamily: 'Work Sans',
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      _ActivityRadio(isSelected: isSelected),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        CustomButton(
          text: widget.continueText,
          width: width * 0.9,
          height: 56,
          style: Styles.textStyle18.copyWith(
            fontFamily: 'Work Sans',
            fontWeight: FontWeight.w600,
          ),
          radius: 19,
          onTap: () {
            widget.onContinue?.call();
            final route = widget.nextRoute;
            if (route != null) {
              GoRouter.of(context).push(route);
            }
          },
        ),
      ],
    );
  }
}

class _ActivityRadio extends StatelessWidget {
  const _ActivityRadio({required this.isSelected});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected ? Colors.white : Colors.white60,
          width: 1.6,
        ),
      ),
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: isSelected ? 12 : 0,
          height: isSelected ? 12 : 0,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}
