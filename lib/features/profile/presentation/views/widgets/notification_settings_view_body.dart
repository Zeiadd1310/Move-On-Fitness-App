import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_on/core/utils/functions/api_service.dart';
import 'package:move_on/core/widgets/custom_assessment_text_widget.dart';
import 'package:move_on/core/widgets/custom_error_snackbar.dart';
import 'package:move_on/features/profile/data/repos/notification_repo_impl.dart';
import 'package:move_on/features/profile/presentation/cubits/notification_cubit/notification_cubit.dart';
import 'package:move_on/features/profile/presentation/cubits/notification_cubit/notification_state.dart';
import 'package:move_on/features/profile/presentation/views/widgets/custom_text_toggle_widget.dart';

class NotificationSettingsViewBody extends StatelessWidget {
  const NotificationSettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          NotificationCubit(NotificationRepoImpl(ApiService()))..init(),
      child: const _NotificationSettingsContent(),
    );
  }
}

class _NotificationSettingsContent extends StatelessWidget {
  const _NotificationSettingsContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomAssessmentTextWidget(text: 'Notification Settings'),
            Expanded(
              child: BlocConsumer<NotificationCubit, NotificationState>(
                listener: (context, state) {
                  if (state is NotificationError) {
                    CustomErrorSnackBar.show(context, state.message);
                  }
                },
                builder: (context, state) {
                  final loaded = state is NotificationLoaded ? state : null;
                  final prefs = loaded?.prefs;

                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextToggleWidget(
                          text: 'General Notification',
                          value: prefs?.general ?? true,
                          onChanged: (v) =>
                              context.read<NotificationCubit>().setGeneral(v),
                        ),
                        const SizedBox(height: 40),
                        CustomTextToggleWidget(
                          text: 'Sound',
                          value: prefs?.sound ?? true,
                          onChanged: (v) =>
                              context.read<NotificationCubit>().setSound(v),
                        ),
                        const SizedBox(height: 40),
                        CustomTextToggleWidget(
                          text: "Don't Disturb Mode",
                          value: prefs?.doNotDisturb ?? false,
                          onChanged: (v) => context
                              .read<NotificationCubit>()
                              .setDoNotDisturb(v),
                        ),
                        const SizedBox(height: 40),
                        CustomTextToggleWidget(
                          text: 'Vibrate',
                          value: prefs?.vibrate ?? true,
                          onChanged: (v) =>
                              context.read<NotificationCubit>().setVibrate(v),
                        ),
                        const SizedBox(height: 40),
                        CustomTextToggleWidget(
                          text: 'Lock Screen',
                          value: prefs?.lockScreen ?? true,
                          onChanged: (v) => context
                              .read<NotificationCubit>()
                              .setLockScreen(v),
                        ),
                        const SizedBox(height: 40),
                        CustomTextToggleWidget(
                          text: 'Reminders',
                          value: prefs?.reminders ?? true,
                          onChanged: (v) =>
                              context.read<NotificationCubit>().setReminders(v),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
