import 'package:flutter/material.dart';
import 'package:move_on/core/utils/functions/styles.dart';
import 'package:move_on/features/welcome/presentation/views/widgets/custom_back_button.dart';
import 'package:move_on/features/welcome/presentation/views/widgets/custom_button.dart';

class AssessmentThreeViewBody extends StatefulWidget {
  const AssessmentThreeViewBody({super.key});

  @override
  State<AssessmentThreeViewBody> createState() =>
      _AssessmentThreeViewBodyState();
}

class _AssessmentThreeViewBodyState extends State<AssessmentThreeViewBody> {
  int _selectedDays = 5;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.05,
            vertical: height * 0.03,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CustomBackButton(width: 48, height: 48),
                  const SizedBox(width: 12),
                  Text(
                    'Assessment',
                    style: Styles.textStyle24.copyWith(
                      fontFamily: 'Work Sans',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.07),
              Center(
                child: Text(
                  'How many days/wk\nwill you commit?',
                  textAlign: TextAlign.center,
                  style: Styles.textStyle36.copyWith(
                    fontFamily: 'Work Sans',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              // big "5x" text
              Center(
                child: Text(
                  '${_selectedDays}x',
                  style: Styles.textStyle36.copyWith(
                    fontSize: 180,
                    fontFamily: 'Work Sans',
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(height: height * 0.04),
              _DaysSlider(
                selected: _selectedDays,
                onChanged: (value) {
                  setState(() => _selectedDays = value);
                },
              ),
              SizedBox(height: height * 0.04),
              Center(
                child: Text.rich(
                  TextSpan(
                    text: "I'm committed to exercising ",
                    style: Styles.textStyle18.copyWith(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(
                        text: '${_selectedDays}x ',
                        style: Styles.textStyle24.copyWith(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: 'weekly',
                        style: Styles.textStyle18.copyWith(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(),
              CustomButton(
                text: 'Continue  →',
                width: width * 0.9,
                height: 56,
                style: Styles.textStyle18.copyWith(
                  fontFamily: 'Work Sans',
                  fontWeight: FontWeight.w600,
                ),
                radius: 19,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DaysSlider extends StatelessWidget {
  const _DaysSlider({required this.selected, required this.onChanged});

  final int selected;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

    return Container(
      width: width * 0.9,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
      decoration: BoxDecoration(
        color: const Color(0xff25282F),
        borderRadius: BorderRadius.circular(27),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(5, (index) {
          final day = index + 1;
          final isSelected = day == selected;
          if (isSelected) {
            return Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: const Color(0xffF97316),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Color(0xff2563EB).withOpacity(0.6),
                  width: 2,
                ),
              ),
              child: Center(
                child: Text(
                  '$day',
                  style: Styles.textStyle20.copyWith(
                    fontFamily: 'Work Sans',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }
          return GestureDetector(
            onTap: () => onChanged(day),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Text(
                '$day',
                style: Styles.textStyle16.copyWith(
                  fontFamily: 'Work Sans',
                  color: Colors.white70,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
