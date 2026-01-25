import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/constants.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/core/utils/functions/responsive_helper.dart';
import 'package:move_on/core/utils/functions/styles.dart';
import 'package:move_on/features/profile/presentation/views/widgets/custom_edit_text_field_widget.dart';
import 'package:move_on/features/profile/presentation/views/widgets/profile_header_card.dart';
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
    final responsive = ResponsiveHelper(context);
    final headerHeight = responsive.heightPercent(0.38);
    final horizontalPadding = responsive.horizontalPadding();
    final verticalPadding = responsive.verticalPadding();
    final topOffset = responsive.heightPercent(0.01);
    final headerOffset = responsive.heightPercent(0.09);
    final buttonWidth = responsive.buttonWidth(160);
    final buttonHeight = responsive.buttonHeight(50);
    final buttonFontSize = responsive.fontSize(18);

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
                name: 'Zeiad Ramadan',
                email: 'zeiadramadan@example.com',
                birthday: 'Birthday: April 05',
                weightText: '75 Kg',
                ageText: '21',
                heightText: '175 CM',
                profileImageUrl: profileImageUrl,
                profileImageAsset: profileImageAsset,
                profileImageFile: profileImageFile,
                isEditMode: true,
                onImageEdit: () {
                  // TODO: Implement image picker functionality
                  print('Edit image tapped');
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
                    const CustomEditTextFieldWidget(text: 'Full name'),
                    const CustomEditTextFieldWidget(text: 'Email'),
                    const CustomEditTextFieldWidget(text: 'Mobile Number'),
                    const CustomEditTextFieldWidget(text: 'Date Of Birth'),
                    const CustomEditTextFieldWidget(text: 'Weight'),
                    const CustomEditTextFieldWidget(text: 'Height'),
                    CustomButton(
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
