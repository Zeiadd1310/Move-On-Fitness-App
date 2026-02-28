import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/core/utils/helpers/responsive_helper.dart';
import 'package:move_on/features/profile/presentation/views/widgets/logout_bottom_sheet.dart';
import 'package:move_on/features/profile/presentation/views/widgets/profile_action_tile.dart';
import 'package:move_on/features/workout/presentation/views/widgets/custom_assessment_text_widget.dart';

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);
    final horizontalPadding = responsive.horizontalPadding();
    final verticalPadding = responsive.verticalPadding();
    final topSpacing = responsive.heightPercent(0.075);
    final spacing = responsive.spacing(20);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAssessmentTextWidget(text: 'Settings'),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              child: Column(
                children: [
                  SizedBox(height: topSpacing),
                  ProfileActionTile(
                    icon: Icons.notifications,
                    title: 'Notification Settings',
                    onTap: () {
                      GoRouter.of(
                        context,
                      ).push(AppRouter.kNotificationSettingsView);
                    },
                  ),
                  SizedBox(height: spacing),
                  ProfileActionTile(
                    icon: Icons.key,
                    title: 'Password Settings',
                    onTap: () {
                      GoRouter.of(
                        context,
                      ).push(AppRouter.kPasswordSettingsView);
                    },
                  ),
                  SizedBox(height: spacing),
                  ProfileActionTile(
                    icon: Icons.person,
                    title: 'Delete Account',
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        builder: (context) {
                          return LogoutBottomSheet(
                            text:
                                'Are you sure you want to delete your account?',
                            option1: 'Cancel',
                            option2: 'Delete',
                            onLogout: () {
                              GoRouter.of(context).go(AppRouter.kSignInView);
                            },
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
