import 'dart:io';
import 'package:flutter/material.dart';
import 'package:move_on/constants.dart';
import 'package:move_on/core/utils/functions/styles.dart';
import 'package:move_on/features/profile/presentation/widgets/profile_stat.dart';
import 'package:move_on/features/profile/presentation/widgets/profile_vertical_divider.dart';

class ProfileHeaderCard extends StatelessWidget {
  const ProfileHeaderCard({
    super.key,
    required this.title,
    required this.name,
    required this.email,
    required this.birthday,
    required this.weightText,
    required this.ageText,
    required this.heightText,
    this.profileImageUrl,
    this.profileImageAsset,
    this.profileImageFile,
    this.isEditMode = false,
    this.onImageEdit,
  });

  final String title;
  final String name;
  final String email;
  final String birthday;
  final String weightText;
  final String ageText;
  final String heightText;

  /// Network image URL (e.g., 'https://example.com/image.jpg')
  final String? profileImageUrl;

  /// Asset image path (e.g., 'assets/images/profile.png')
  final String? profileImageAsset;

  /// File path (e.g., '/path/to/image.jpg')
  final String? profileImageFile;

  /// Whether this card is in edit mode
  final bool isEditMode;

  /// Callback when the edit image button is tapped
  final VoidCallback? onImageEdit;

  ImageProvider? _getImageProvider() {
    if (profileImageUrl != null) {
      return NetworkImage(profileImageUrl!);
    } else if (profileImageAsset != null) {
      return AssetImage(profileImageAsset!);
    } else if (profileImageFile != null) {
      return FileImage(File(profileImageFile!));
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () => Navigator.of(context).maybePop(),
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
            ),
            const SizedBox(width: 6),
            Text(
              title,
              style: Styles.textStyle24.copyWith(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.black54,
                    backgroundImage: _getImageProvider(),
                    child: _getImageProvider() == null
                        ? const Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 60,
                          )
                        : null,
                  ),
                  if (isEditMode)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: onImageEdit,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.edit_outlined,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                name,
                style: Styles.textStyle24.copyWith(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                email,
                style: Styles.textStyle16.copyWith(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  color: Colors.white70,
                ),
              ),
              Text(
                birthday,
                style: Styles.textStyle16.copyWith(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ProfileStat(value: weightText, label: 'Weight'),
                  const ProfileVerticalDivider(
                    color: Colors.white,
                    height: 50,
                    width: 2,
                  ),
                  ProfileStat(value: ageText, label: 'Years Old'),
                  const ProfileVerticalDivider(
                    color: Colors.white,
                    height: 50,
                    width: 2,
                  ),
                  ProfileStat(value: heightText, label: 'Height'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
