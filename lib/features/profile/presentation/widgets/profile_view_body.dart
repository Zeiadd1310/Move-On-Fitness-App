import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/constants.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/features/profile/presentation/widgets/logout_bottom_sheet.dart';
import 'package:move_on/features/profile/presentation/widgets/profile_action_tile.dart';
import 'package:move_on/features/profile/presentation/widgets/profile_header_card.dart';

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
    final size = MediaQuery.of(context).size;
    final headerHeight = size.height * 0.38;
    return Stack(
      children: [
        Column(
          children: [
            Container(height: headerHeight, color: kPrimaryColor),
            Expanded(child: Container(color: Colors.black)),
          ],
        ),
        Positioned(
          left: 16,
          right: 16,
          top: 10,
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
          top: headerHeight + 70,
          bottom: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
                const SizedBox(height: 12),
                ProfileActionTile(
                  icon: Icons.settings_outlined,
                  title: 'Settings',
                  onTap: () {
                    GoRouter.of(context).push(AppRouter.kSettingsView);
                  },
                ),
                const SizedBox(height: 12),
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
