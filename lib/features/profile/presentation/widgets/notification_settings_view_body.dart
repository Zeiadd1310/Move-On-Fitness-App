import 'package:flutter/material.dart';
import 'package:move_on/features/profile/presentation/widgets/custom_text_toggle_widget.dart';
import 'package:move_on/features/workout/presentation/views/widgets/custom_assessment_text_widget.dart';

class NotificationSettingsViewBody extends StatelessWidget {
  const NotificationSettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAssessmentTextWidget(text: 'Notification Settings'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  CustomTextToggleWidget(text: 'General Notification'),
                  const SizedBox(height: 40),
                  CustomTextToggleWidget(text: 'Sound'),
                  const SizedBox(height: 40),
                  CustomTextToggleWidget(text: 'Don\'t Disturb Mode'),
                  const SizedBox(height: 40),
                  CustomTextToggleWidget(text: 'Vibrate'),
                  const SizedBox(height: 40),
                  CustomTextToggleWidget(text: 'Lock Screen'),
                  const SizedBox(height: 40),
                  CustomTextToggleWidget(text: 'Reminders'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
