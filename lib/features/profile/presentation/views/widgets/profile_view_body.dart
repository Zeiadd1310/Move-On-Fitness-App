import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/constants.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/core/utils/functions/responsive_helper.dart';
import 'package:move_on/features/profile/presentation/views/widgets/logout_bottom_sheet.dart';
import 'package:move_on/features/profile/presentation/views/widgets/profile_action_tile.dart';
import 'package:move_on/features/profile/presentation/views/widgets/profile_header_card.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({
    super.key,
    this.profileImageUrl,
    this.profileImageAsset,
    this.profileImageFile,
  });

  final String? profileImageUrl;
  final String? profileImageAsset;
  final String? profileImageFile;

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);
    final headerHeight = responsive.heightPercent(0.38);
    final horizontalPadding = responsive.horizontalPadding();
    final verticalPadding = responsive.verticalPadding();
    final topOffset = responsive.heightPercent(0.01);
    final headerOffset = responsive.heightPercent(0.09);
    final spacing = responsive.spacing(12);
    
    return Stack(
      children: [
        Column(
          children: [
            Container(height: headerHeight, color: kPrimaryColor),
            Expanded(child: Container(color: Colors.black)),
          ],
        ),
        Positioned(
          left: horizontalPadding,
          right: horizontalPadding,
          top: topOffset,
          child: ProfileHeaderCard(
            title: 'My Profile',
            name: 'Zeiad Ramadan',
            email: 'zeiadramadan@example.com',
            birthday: 'Birthday: April 05',
            weightText: '75 Kg',
            ageText: '21',
            heightText: '175 CM',
            profileImageUrl: profileImageUrl,
            profileImageAsset: profileImageAsset,
            profileImageFile: profileImageFile,
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: headerHeight + headerOffset,
          bottom: 0,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileActionTile(
                  icon: Icons.person_outline,
                  title: 'Edit Profile',
                  onTap: () {
                    GoRouter.of(context).push(AppRouter.kEditProfileView);
                  },
                ),
                SizedBox(height: spacing),
                ProfileActionTile(
                  icon: Icons.settings_outlined,
                  title: 'Settings',
                  onTap: () {
                    GoRouter.of(context).push(AppRouter.kSettingsView);
                  },
                ),
                SizedBox(height: spacing),
                ProfileActionTile(
                  icon: Icons.logout,
                  title: 'Logout',
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      builder: (_) {
                        return LogoutBottomSheet(
                          text: 'Are you sure you want to\nlogout?',
                          option1: 'Cancel',
                          option2: 'Yes, logout',
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
        ),
      ],
    );
  }
}
