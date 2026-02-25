import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/core/utils/functions/responsive_helper.dart';
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
    final responsive = ResponsiveHelper(context);
    final horizontalPadding = responsive.horizontalPadding();
    final verticalPadding = responsive.verticalPadding();
    final largeSpacing = responsive.heightPercent(0.07);
    final mediumSpacing = responsive.heightPercent(0.04);
    final smallSpacing = responsive.heightPercent(0.02);
    final backButtonSize = responsive.iconSize(48);
    final titleFontSize = responsive.fontSize(24);
    final questionFontSize = responsive.fontSize(36);
    final bigNumberFontSize = responsive.fontSize(180);
    final textFontSize = responsive.fontSize(18);
    final textBoldFontSize = responsive.fontSize(24);
    final rowSpacing = responsive.spacing(12);
    final buttonWidth = responsive.widthPercent(0.9);
    final buttonHeight = responsive.buttonHeight(56);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CustomBackButton(
                    width: backButtonSize,
                    height: backButtonSize,
                  ),
                  SizedBox(width: rowSpacing),
                  Text(
                    'Assessment',
                    style: Styles.textStyle24.copyWith(
                      fontFamily: 'Work Sans',
                      fontWeight: FontWeight.bold,
                      fontSize: titleFontSize,
                    ),
                  ),
                ],
              ),
              SizedBox(height: largeSpacing),
              Center(
                child: Text(
                  'How many days/wk\nwill you commit?',
                  textAlign: TextAlign.center,
                  style: Styles.textStyle36.copyWith(
                    fontFamily: 'Work Sans',
                    fontWeight: FontWeight.bold,
                    fontSize: questionFontSize,
                  ),
                ),
              ),
              SizedBox(height: smallSpacing),
              // big "5x" text
              Center(
                child: Text(
                  '${_selectedDays}x',
                  style: Styles.textStyle36.copyWith(
                    fontSize: bigNumberFontSize,
                    fontFamily: 'Work Sans',
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(height: mediumSpacing),
              _DaysSlider(
                selected: _selectedDays,
                onChanged: (value) {
                  setState(() => _selectedDays = value);
                },
                responsive: responsive,
              ),
              SizedBox(height: mediumSpacing),
              Center(
                child: Text.rich(
                  TextSpan(
                    text: "I'm committed to exercising ",
                    style: Styles.textStyle18.copyWith(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: textFontSize,
                    ),
                    children: [
                      TextSpan(
                        text: '${_selectedDays}x ',
                        style: Styles.textStyle24.copyWith(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: textBoldFontSize,
                        ),
                      ),
                      TextSpan(
                        text: 'weekly',
                        style: Styles.textStyle18.copyWith(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          fontSize: textFontSize,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(),
              CustomButton(
                text: 'Continue',
                width: buttonWidth,
                height: buttonHeight,
                style: Styles.textStyle18.copyWith(
                  fontFamily: 'Work Sans',
                  fontWeight: FontWeight.w600,
                  fontSize: textFontSize,
                ),
                radius: 19,
                onTap: () {
                  GoRouter.of(context).push(AppRouter.kOneDayView);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DaysSlider extends StatelessWidget {
  const _DaysSlider({
    required this.selected,
    required this.onChanged,
    required this.responsive,
  });

  final int selected;
  final ValueChanged<int> onChanged;
  final ResponsiveHelper responsive;

  @override
  Widget build(BuildContext context) {
    final sliderWidth = responsive.widthPercent(0.9);
    final horizontalPadding = responsive.spacing(12);
    final verticalPadding = responsive.spacing(24);
    final dayButtonSize = responsive.iconSize(54);
    final selectedFontSize = responsive.fontSize(20);
    final unselectedFontSize = responsive.fontSize(16);
    final borderRadius = responsive.clamp(27.0, 20.0, 35.0);
    final dayBorderRadius = responsive.clamp(16.0, 12.0, 20.0);
    final itemPadding = responsive.spacing(3);

    return Container(
      width: sliderWidth,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      decoration: BoxDecoration(
        color: const Color(0xff25282F),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(5, (index) {
          final day = index + 1;
          final isSelected = day == selected;
          if (isSelected) {
            return Container(
              width: dayButtonSize,
              height: dayButtonSize,
              decoration: BoxDecoration(
                color: const Color(0xffF97316),
                borderRadius: BorderRadius.circular(dayBorderRadius),
              ),
              child: Center(
                child: Text(
                  '$day',
                  style: Styles.textStyle20.copyWith(
                    fontFamily: 'Work Sans',
                    fontWeight: FontWeight.bold,
                    fontSize: selectedFontSize,
                  ),
                ),
              ),
            );
          }
          return InkWell(
            onTap: () => onChanged(day),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: itemPadding),
              child: Text(
                '$day',
                style: Styles.textStyle16.copyWith(
                  fontFamily: 'Work Sans',
                  color: Colors.white70,
                  fontSize: unselectedFontSize,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
