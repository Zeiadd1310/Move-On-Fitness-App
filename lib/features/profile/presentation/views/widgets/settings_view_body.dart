import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/core/services/local_storage_service.dart';
import 'package:move_on/core/utils/functions/api_service.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/core/utils/helpers/responsive_helper.dart';
import 'package:move_on/features/profile/data/repos/profile_repo.dart';
import 'package:move_on/features/profile/data/repos/profile_repo_impl.dart';
import 'package:move_on/features/profile/presentation/cubits/delete_account_cubit/delete_account_cubit.dart';
import 'package:move_on/features/profile/presentation/cubits/delete_account_cubit/delete_account_state.dart';
import 'package:move_on/features/profile/presentation/views/widgets/logout_bottom_sheet.dart';
import 'package:move_on/features/profile/presentation/views/widgets/profile_action_tile.dart';
import 'package:move_on/core/widgets/custom_assessment_text_widget.dart';

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);
    final horizontalPadding = responsive.horizontalPadding();
    final verticalPadding = responsive.verticalPadding();
    final topSpacing = responsive.heightPercent(0.075);
    final spacing = responsive.spacing(20);

    return BlocProvider(
      create: (context) => DeleteAccountCubit(
        ProfileRepoImpl(
          apiService: ApiService(),
          localStorageService: LocalStorageService(),
        ),
      ),

      child: BlocListener<DeleteAccountCubit, DeleteAccountState>(
        listener: (context, state) {
          if (state is DeleteAccountSuccess) {
            context.go(AppRouter.kSignInView);
          } else if (state is DeleteAccountError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.redAccent,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            );
          }
        },
        child: Scaffold(
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
                          context.push(AppRouter.kNotificationSettingsView);
                        },
                      ),
                      SizedBox(height: spacing),
                      ProfileActionTile(
                        icon: Icons.key,
                        title: 'Password Settings',
                        onTap: () {
                          context.push(AppRouter.kPasswordSettingsView);
                        },
                      ),
                      SizedBox(height: spacing),
                      Builder(
                        builder: (context) => ProfileActionTile(
                          icon: Icons.person,
                          title: 'Delete Account',
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.transparent,
                              isScrollControlled: true,
                              builder: (sheetContext) {
                                return LogoutBottomSheet(
                                  text:
                                      'Are you sure you want to delete your account?',
                                  option1: 'Cancel',
                                  option2: 'Delete',
                                  onLogout: () {
                                    Navigator.pop(sheetContext);
                                    context
                                        .read<DeleteAccountCubit>()
                                        .deleteAccount();
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
