import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/constants.dart';
import 'package:move_on/core/services/local_storage_service.dart';
import 'package:move_on/core/utils/functions/api_service.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/core/utils/helpers/responsive_helper.dart';
import 'package:move_on/core/widgets/custom_error_snackbar.dart';
import 'package:move_on/features/authentication/data/repos/auth_repo_impl.dart';
import 'package:move_on/features/profile/data/models/user_profile_model.dart';
import 'package:move_on/features/profile/data/repos/profile_repo_impl.dart';
import 'package:move_on/features/profile/presentation/views/widgets/logout_bottom_sheet.dart';
import 'package:move_on/features/profile/presentation/views/widgets/profile_action_tile.dart';
import 'package:move_on/features/profile/presentation/views/widgets/profile_header_card.dart';

class ProfileViewBody extends StatefulWidget {
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
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  late final ProfileRepoImpl _profileRepo;
  UserProfileModel? _profile;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _profileRepo = ProfileRepoImpl(
      apiService: ApiService(),
      localStorageService: LocalStorageService(),
    );
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final localStorage = LocalStorageService();
    final cached = await localStorage.loadCachedUserProfile();
    if (cached != null && mounted) {
      setState(() {
        _profile = UserProfileModel.fromJson(cached);
      });
    }

    try {
      final remote = await _profileRepo.getMyProfile();
      if (!mounted) return;
      setState(() {
        _profile = remote;
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);
    final headerHeight = responsive.heightPercent(0.38);
    final horizontalPadding = responsive.horizontalPadding();
    final verticalPadding = responsive.verticalPadding();
    final topOffset = responsive.heightPercent(0.01);
    final headerOffset = responsive.heightPercent(0.09);
    final spacing = responsive.spacing(12);
    final profile = _profile;

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
            name: profile?.fullName.isNotEmpty == true
                ? profile!.fullName
                : 'Complete your profile',
            email: profile?.email.isNotEmpty == true
                ? profile!.email
                : 'No email',
            birthday: profile?.dateOfBirth.isNotEmpty == true
                ? 'Birthday: ${profile!.formattedDateOfBirth}'
                : 'Birthday: --',
            weightText: profile?.weight.isNotEmpty == true
                ? '${profile!.weight} Kg'
                : '-- Kg',
            ageText: profile?.ageInYearsText ?? '--',
            heightText: profile?.height.isNotEmpty == true
                ? '${profile!.height} CM'
                : '-- CM',
            profileImageUrl: widget.profileImageUrl,
            profileImageAsset: widget.profileImageAsset,
            profileImageFile: widget.profileImageFile,
            onBackPressed: () {
              final navigator = Navigator.of(context);
              if (navigator.canPop()) {
                navigator.pop();
              } else {
                GoRouter.of(context).go(AppRouter.kHomeView);
              }
            },
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: headerHeight + headerOffset,
          bottom: 0,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_isLoading)
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: LinearProgressIndicator(minHeight: 2),
                  ),
                ProfileActionTile(
                  icon: Icons.person_outline,
                  title: 'Edit Profile',
                  onTap: () {
                    GoRouter.of(context).push(
                      AppRouter.kEditProfileView,
                      extra: {
                        'fullName': profile?.fullName ?? '',
                        'email': profile?.email ?? '',
                        'mobileNumber': profile?.mobileNumber ?? '',
                        'dateOfBirth': profile?.dateOfBirth ?? '',
                        'weight': profile?.weight ?? '',
                        'height': profile?.height ?? '',
                      },
                    );
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
                            _handleLogout(context);
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

  Future<void> _handleLogout(BuildContext context) async {
    final authRepo = AuthRepoImpl(ApiService());
    final localStorage = LocalStorageService();

    final result = await authRepo.logout();
    await result.fold(
      (failure) async {
        await localStorage.setSignedIn(false);
        await localStorage.clearToken();
        await localStorage.clearCachedUserProfile();
        if (context.mounted) {
          CustomErrorSnackBar.show(context, failure.errMessage);
          GoRouter.of(context).go(AppRouter.kSignInView);
        }
      },
      (_) async {
        await localStorage.setSignedIn(false);
        await localStorage.clearToken();
        await localStorage.clearCachedUserProfile();
        if (context.mounted) {
          GoRouter.of(context).go(AppRouter.kSignInView);
        }
      },
    );
  }
}
