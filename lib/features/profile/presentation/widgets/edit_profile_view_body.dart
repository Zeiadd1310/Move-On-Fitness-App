import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/constants.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/core/utils/functions/styles.dart';
import 'package:move_on/features/profile/presentation/widgets/custom_edit_text_field_widget.dart';
import 'package:move_on/features/profile/presentation/widgets/profile_header_card.dart';
import 'package:move_on/features/welcome/presentation/views/widgets/custom_button.dart';

class EditProfileViewBody extends StatelessWidget {
  const EditProfileViewBody({
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

    return SafeArea(
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(height: headerHeight, color: kPrimaryColor),
                Container(height: size.height, color: Colors.black),
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
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 16,
                ),
                child: Column(
                  children: [
                    const CustomEditTextFieldWidget(text: 'Full name'),
                    const CustomEditTextFieldWidget(text: 'Email'),
                    const CustomEditTextFieldWidget(text: 'Mobile Number'),
                    const CustomEditTextFieldWidget(text: 'Date Of Birth'),
                    const CustomEditTextFieldWidget(text: 'Weight'),
                    const CustomEditTextFieldWidget(text: 'Height'),
                    CustomButton(
                      text: 'Update Profile',
                      width: 160,
                      height: 50,
                      style: Styles.textStyle18.copyWith(
                        fontFamily: 'League Spartan',
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      radius: 100,
                      color: Colors.white,
                      onTap: () {
                        GoRouter.of(context).push(AppRouter.kProfileView);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
