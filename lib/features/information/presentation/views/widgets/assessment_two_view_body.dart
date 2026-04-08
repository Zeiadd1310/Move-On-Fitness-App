import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/core/utils/helpers/responsive_helper.dart';
import 'package:move_on/core/utils/functions/styles.dart';
import 'package:move_on/core/widgets/custom_error_snackbar.dart';
import 'package:move_on/features/information/presentation/cubits/goal_cubit/goal_cubit.dart';
import 'package:move_on/features/information/presentation/views/widgets/custom_assessment_options_widget.dart';
import 'package:move_on/features/welcome/presentation/views/widgets/custom_back_button.dart';

class AssessmentTwoViewBody extends StatelessWidget {
  final int assessmentId;
  final int activityLevel;

  const AssessmentTwoViewBody({
    super.key,
    required this.assessmentId,
    required this.activityLevel,
  });

  static const _goalOptions = [
    'Lose Weight',
    'Gain Muscle',
    'Gain Muscles and Lose Weight',
  ];

  static String _goalToApiValue(String selected) {
    switch (selected) {
      case 'Lose Weight':
        return 'LoseWeight';
      case 'Gain Muscle':
        return 'GainMuscle';
      case 'Gain Muscles and Lose Weight':
        return 'GainMusclesAndLoseWeight';
      default:
        return 'LoseWeight';
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);
    final horizontalPadding = responsive.horizontalPadding();
    final verticalPadding = responsive.verticalPadding();
    final spacing = responsive.heightPercent(0.04);
    final backButtonSize = responsive.iconSize(48);
    final titleFontSize = responsive.fontSize(24);
    final rowSpacing = responsive.spacing(12);

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
              SizedBox(height: spacing),
              Expanded(
                child: BlocBuilder<GoalCubit, GoalState>(
                  builder: (context, state) {
                    final selectedIndex = state.selectedGoal == null
                        ? -1
                        : _goalOptions.indexOf(state.selectedGoal!);

                    return CustomAssessmentOptionsWidget(
                      title: 'What\'s your fitness\ngoal/target?',
                      subtitle: 'This helps us create your personalized plan',
                      options: _goalOptions,
                      initialSelectedIndex: selectedIndex,
                      onChanged: (index) {
                        context.read<GoalCubit>().selectGoal(
                          _goalOptions[index],
                        );
                      },
                      onContinue: () {
                        final selected = context.read<GoalCubit>().selectedGoal;
                        if (selected == null) {
                          CustomErrorSnackBar.show(
                            context,
                            'Please choose your goal first',
                          );
                          return;
                        }

                        GoRouter.of(context).push(
                          AppRouter.kAssessmentThreeView,
                          extra: {
                            'assessmentId': assessmentId,
                            'activityLevel': activityLevel,
                            'goal': _goalToApiValue(selected),
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
