import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/core/utils/helpers/responsive_helper.dart';
import 'package:move_on/core/utils/functions/styles.dart';
import 'package:move_on/core/widgets/custom_error_snackbar.dart';
import 'package:move_on/features/information/presentation/cubits/activity_level_cubit/activity_level_cubit.dart';
import 'package:move_on/features/information/presentation/views/widgets/custom_assessment_options_widget.dart';
import 'package:move_on/features/welcome/presentation/views/widgets/custom_back_button.dart';

class AssessmentOneViewBody extends StatelessWidget {
  final int assessmentId;

  const AssessmentOneViewBody({super.key, required this.assessmentId});

  static const _activityOptions = ['Beginner', 'Intermediate', 'Advanced'];

  static int _activityToApiValue(String selected) {
    switch (selected) {
      case 'Beginner':
        return 0;
      case 'Intermediate':
        return 1;
      case 'Advanced':
        return 2;
      default:
        return 1;
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
                child: BlocBuilder<ActivityLevelCubit, ActivityLevelState>(
                  builder: (context, state) {
                    final selectedIndex = state.selectedActivityLevel == null
                        ? -1
                        : _activityOptions.indexOf(
                            state.selectedActivityLevel!,
                          );

                    return CustomAssessmentOptionsWidget(
                      title: 'Your Regular Physical Activity Level ?',
                      subtitle: 'This helps us create your personalized plan',
                      options: _activityOptions,
                      initialSelectedIndex: selectedIndex,
                      onChanged: (index) {
                        context.read<ActivityLevelCubit>().selectActivityLevel(
                          _activityOptions[index],
                        );
                      },
                      onContinue: () {
                        final selected = context
                            .read<ActivityLevelCubit>()
                            .selectedActivityLevel;
                        if (selected == null) {
                          CustomErrorSnackBar.show(
                            context,
                            'Please choose your activity level first',
                          );
                          return;
                        }

                        GoRouter.of(context).push(
                          AppRouter.kAssessmentTwoView,
                          extra: {
                            'assessmentId': assessmentId,
                            'activityLevel': _activityToApiValue(selected),
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
