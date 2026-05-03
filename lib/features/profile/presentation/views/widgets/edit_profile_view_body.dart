import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:move_on/constants.dart';
import 'package:move_on/core/services/local_storage_service.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/core/utils/helpers/responsive_helper.dart';
import 'package:move_on/core/utils/functions/styles.dart';
import 'package:move_on/core/widgets/custom_error_snackbar.dart';
import 'package:move_on/features/profile/presentation/views/widgets/custom_edit_text_field_widget.dart';
import 'package:move_on/features/profile/data/models/user_profile_model.dart';
import 'package:move_on/features/profile/presentation/cubits/edit_profile_cubit/edit_profile_cubit.dart';
import 'package:move_on/features/profile/presentation/views/widgets/profile_header_card.dart';
import 'package:move_on/features/welcome/presentation/views/widgets/custom_button.dart';

class EditProfileViewBody extends StatefulWidget {
  const EditProfileViewBody({
    super.key,
    this.profileImageUrl,
    this.profileImageAsset,
    this.profileImageFile,
    this.firstTimeSetup = false,
    this.initialName,
    this.initialEmail,
    this.initialMobileNumber,
    this.initialDateOfBirth,
    this.initialWeight,
    this.initialHeight,
  });

  final String? profileImageUrl;
  final String? profileImageAsset;
  final String? profileImageFile;
  final bool firstTimeSetup;
  final String? initialName;
  final String? initialEmail;
  final String? initialMobileNumber;
  final String? initialDateOfBirth;
  final String? initialWeight;
  final String? initialHeight;

  @override
  State<EditProfileViewBody> createState() => _EditProfileViewBodyState();
}

class _EditProfileViewBodyState extends State<EditProfileViewBody> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _dobController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _localStorageService = LocalStorageService();
  final _imagePicker = ImagePicker();
  String? _selectedProfileImagePath;
  String? _uploadedProfileImageUrl;

  @override
  void initState() {
    super.initState();
    _uploadedProfileImageUrl = widget.profileImageUrl;
    _fullNameController.text = widget.initialName?.trim() ?? '';
    _emailController.text = widget.initialEmail?.trim() ?? '';
    _mobileController.text = widget.initialMobileNumber?.trim() ?? '';
    _dobController.text = widget.initialDateOfBirth?.trim() ?? '';
    _weightController.text = widget.initialWeight?.trim() ?? '';
    _heightController.text = widget.initialHeight?.trim() ?? '';
    _loadCachedPrefillData();
  }

  Future<void> _loadCachedPrefillData() async {
    final cachedProfileMap = await _localStorageService.loadCachedUserProfile();
    final cached = await _localStorageService.getPendingProfileData();
    if (!mounted) return;

    final cachedProfile = cachedProfileMap == null
        ? null
        : UserProfileModel.fromJson(cachedProfileMap);
    setState(() {
      if (_fullNameController.text.trim().isEmpty) {
        _fullNameController.text = cachedProfile?.fullName.isNotEmpty == true
            ? cachedProfile!.fullName
            : (cached['fullName'] ?? '');
      }
      if (_emailController.text.trim().isEmpty) {
        _emailController.text = cachedProfile?.email.isNotEmpty == true
            ? cachedProfile!.email
            : (cached['email'] ?? '');
      }
      if (_mobileController.text.trim().isEmpty) {
        _mobileController.text = cachedProfile?.mobileNumber ?? '';
      }
      if (_dobController.text.trim().isEmpty) {
        final dobRemote = cachedProfile?.dateOfBirth.trim() ?? '';
        _dobController.text = dobRemote.isNotEmpty
            ? dobRemote
            : (cached['dateOfBirth'] ?? '');
      }
      if ((_uploadedProfileImageUrl ?? '').trim().isEmpty) {
        final picRemote = cachedProfile?.profilePictureUrl.trim() ?? '';
        final picPending = cached['profilePictureUrl'] ?? '';
        final chosen = picRemote.isNotEmpty ? picRemote : picPending;
        if (chosen.trim().isNotEmpty) {
          _uploadedProfileImageUrl = chosen.trim();
        }
      }
      if (_weightController.text.trim().isEmpty) {
        _weightController.text = cachedProfile?.weight.isNotEmpty == true
            ? cachedProfile!.weight
            : (cached['weight'] ?? '');
      }
      if (_heightController.text.trim().isEmpty) {
        _heightController.text = cachedProfile?.height.isNotEmpty == true
            ? cachedProfile!.height
            : (cached['height'] ?? '');
      }
    });
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _dobController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);
    final headerHeight = responsive.heightPercent(0.38);
    final horizontalPadding = responsive.horizontalPadding();
    final verticalPadding = responsive.verticalPadding();
    final topOffset = responsive.heightPercent(0.01);
    final headerOffset = responsive.heightPercent(0.09);
    final buttonWidth = responsive.buttonWidth(160);
    final buttonHeight = responsive.buttonHeight(50);
    final buttonFontSize = responsive.fontSize(18);

    return BlocConsumer<EditProfileCubit, EditProfileState>(
      listener: (context, state) async {
        if (state is EditProfileFailure) {
          CustomErrorSnackBar.show(context, state.errorMessage);
        } else if (state is EditProfileImageUploadFailure) {
          CustomErrorSnackBar.show(context, state.errorMessage);
        } else if (state is EditProfileImageUploadSuccess) {
          if (!mounted) return;
          setState(() {
            _uploadedProfileImageUrl = state.imageUrl;
            _selectedProfileImagePath = null;
          });
        } else if (state is EditProfileSuccess) {
          final router = GoRouter.of(context);
          final pic = (_uploadedProfileImageUrl ?? '').trim();
          final dob = _dobController.text.trim();
          await _localStorageService.savePendingProfileData(
            fullName: _fullNameController.text.trim(),
            email: _emailController.text.trim(),
            weight: _weightController.text.trim(),
            height: _heightController.text.trim(),
            profilePictureUrl: pic.isNotEmpty ? pic : null,
            dateOfBirth: dob.isNotEmpty ? dob : null,
          );
          if (widget.firstTimeSetup) {
            router.go(AppRouter.kHomeView);
          } else {
            router.go(AppRouter.kProfileView);
          }
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(height: headerHeight, color: kPrimaryColor),
                    Container(height: responsive.height, color: Colors.black),
                  ],
                ),
                Positioned(
                  left: horizontalPadding,
                  right: horizontalPadding,
                  top: topOffset,
                  child: ProfileHeaderCard(
                    title: 'My Profile',
                    name: _fullNameController.text.trim().isEmpty
                        ? 'Complete your profile'
                        : _fullNameController.text.trim(),
                    email: _emailController.text.trim().isEmpty
                        ? 'No email'
                        : _emailController.text.trim(),
                    birthday: _dobController.text.trim().isEmpty
                        ? 'Birthday: --'
                        : 'Birthday: ${_headerPreviewProfile.formattedDateOfBirth}',
                    weightText: _weightController.text.trim().isEmpty
                        ? '-- Kg'
                        : '${_weightController.text.trim()} Kg',
                    ageText: _headerPreviewProfile.ageInYearsText,
                    heightText: _heightController.text.trim().isEmpty
                        ? '-- CM'
                        : '${_heightController.text.trim()} CM',
                    profileImageUrl:
                        _uploadedProfileImageUrl ?? widget.profileImageUrl,
                    profileImageAsset: widget.profileImageAsset,
                    profileImageFile:
                        _selectedProfileImagePath ?? widget.profileImageFile,
                    isEditMode: true,
                    onImageEdit: _pickAndUploadProfileImage,
                    onBackPressed: () {
                      final navigator = Navigator.of(context);
                      if (navigator.canPop()) {
                        navigator.pop();
                      } else {
                        GoRouter.of(context).go(
                          widget.firstTimeSetup
                              ? AppRouter.kHomeView
                              : AppRouter.kProfileView,
                        );
                      }
                    },
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: headerHeight + headerOffset,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding * 1.5,
                      vertical: verticalPadding,
                    ),
                    child: Column(
                      children: [
                        CustomEditTextFieldWidget(
                          text: 'Full name',
                          controller: _fullNameController,
                          hintText: 'Enter full name',
                          onChanged: (_) => setState(() {}),
                        ),
                        CustomEditTextFieldWidget(
                          text: 'Email',
                          controller: _emailController,
                          hintText: 'Enter email',
                          onChanged: (_) => setState(() {}),
                        ),
                        CustomEditTextFieldWidget(
                          text: 'Mobile Number',
                          controller: _mobileController,
                          hintText: 'Enter mobile number',
                          onChanged: (_) => setState(() {}),
                        ),
                        CustomEditTextFieldWidget(
                          text: 'Date Of Birth',
                          controller: _dobController,
                          hintText: 'YYYY-MM-DD',
                          onChanged: (_) => setState(() {}),
                        ),
                        CustomEditTextFieldWidget(
                          text: 'Weight',
                          controller: _weightController,
                          hintText: 'Enter weight',
                          onChanged: (_) => setState(() {}),
                        ),
                        CustomEditTextFieldWidget(
                          text: 'Height',
                          controller: _heightController,
                          hintText: 'Enter height',
                          onChanged: (_) => setState(() {}),
                        ),
                        state is EditProfileLoading
                            ? const CircularProgressIndicator()
                            : CustomButton(
                                text: 'Update Profile',
                                width: buttonWidth,
                                height: buttonHeight,
                                style: Styles.textStyle18.copyWith(
                                  fontFamily: 'League Spartan',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontSize: buttonFontSize,
                                ),
                                radius: 100,
                                color: Colors.white,
                                onTap: _onUpdateTap,
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onUpdateTap() {
    final fullName = _fullNameController.text.trim();
    final email = _emailController.text.trim();
    final mobileNumber = _mobileController.text.trim();
    final dateOfBirth = _dobController.text.trim();
    final weight = _weightController.text.trim();
    final height = _heightController.text.trim();
    final profilePictureUrl = (_uploadedProfileImageUrl ?? '').trim();

    if (fullName.isEmpty ||
        email.isEmpty ||
        mobileNumber.isEmpty ||
        dateOfBirth.isEmpty ||
        weight.isEmpty ||
        height.isEmpty) {
      CustomErrorSnackBar.show(context, 'Please fill in all fields');
      return;
    }
    if (profilePictureUrl.isEmpty) {
      CustomErrorSnackBar.show(
        context,
        'Please upload a profile picture first.',
      );
      return;
    }

    context.read<EditProfileCubit>().updateProfile(
      fullName: fullName,
      email: email,
      dateOfBirth: dateOfBirth,
      mobileNumber: mobileNumber,
      weight: weight,
      height: height,
      profilePictureUrl: profilePictureUrl,
    );
  }

  UserProfileModel get _headerPreviewProfile {
    return UserProfileModel(
      fullName: _fullNameController.text.trim(),
      email: _emailController.text.trim(),
      dateOfBirth: _dobController.text.trim(),
      mobileNumber: _mobileController.text.trim(),
      weight: _weightController.text.trim(),
      height: _heightController.text.trim(),
    );
  }

  Future<void> _pickAndUploadProfileImage() async {
    try {
      final pickedImage = await _imagePicker.pickImage(
        source: ImageSource.gallery,
      );
      if (pickedImage == null || !mounted) return;

      setState(() {
        _selectedProfileImagePath = pickedImage.path;
      });

      await context.read<EditProfileCubit>().uploadProfilePicture(
        imagePath: pickedImage.path,
      );
    } on PlatformException catch (e) {
      if (!mounted) return;
      CustomErrorSnackBar.show(
        context,
        e.message ?? 'Image picker is unavailable. Please restart the app.',
      );
    } catch (_) {
      if (!mounted) return;
      CustomErrorSnackBar.show(
        context,
        'Could not pick image. Please try again.',
      );
    }
  }
}
