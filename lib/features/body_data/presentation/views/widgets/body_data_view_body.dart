import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/constants.dart';
import 'package:move_on/core/models/oauth_account_snapshot.dart';
import 'package:move_on/core/services/local_storage_service.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/core/utils/helpers/responsive_helper.dart';
import 'package:move_on/core/utils/functions/styles.dart';
import 'package:move_on/core/widgets/custom_assessment_text_widget.dart';
import 'package:move_on/core/widgets/custom_error_snackbar.dart';
import 'package:move_on/features/body_data/data/models/manual_assessment_request_model.dart';
import 'package:move_on/features/body_data/presentation/cubits/manual_assessment_cubit/manual_assessment_cubit.dart';
import 'package:move_on/features/body_data/presentation/views/widgets/body_data_gender_selector.dart';
import 'package:move_on/features/body_data/presentation/views/widgets/body_data_input_field.dart';
import 'package:move_on/features/body_data/presentation/views/widgets/custom_row_text_widget.dart';
import 'package:move_on/features/welcome/presentation/views/widgets/body_data_input_with_unit.dart';
import 'package:move_on/features/welcome/presentation/views/widgets/custom_button.dart';

class BodyDataViewBody extends StatefulWidget {
  const BodyDataViewBody({super.key});

  @override
  State<BodyDataViewBody> createState() => _BodyDataViewBodyState();
}

class _BodyDataViewBodyState extends State<BodyDataViewBody> {
  // Controllers
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _muscleController = TextEditingController();
  final TextEditingController _fatController = TextEditingController();
  final TextEditingController _waterController = TextEditingController();
  final TextEditingController _bmrController = TextEditingController();

  String _selectedGender = 'Male';
  String _weightUnit = 'Kg';
  String _heightUnit = 'Cm';
  String _muscleUnit = 'Kg';
  String _fatUnit = 'Kg';
  String _waterUnit = 'Kg';
  String _bmrUnit = 'Kg';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final storage = LocalStorageService();
      final p = await storage.getPendingProfileData();
      if (!mounted) return;
      final iso = p['dateOfBirth']?.trim();
      final age = OAuthAccountSnapshot.computeAgeYears(iso);
      if (age != null && _ageController.text.trim().isEmpty) {
        setState(() => _ageController.text = '$age');
      }
      final g = p['gender']?.trim() ?? '';
      if (g == 'Male' || g == 'Femail') {
        setState(() => _selectedGender = g);
      }
    });
  }

  @override
  void dispose() {
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _muscleController.dispose();
    _fatController.dispose();
    _waterController.dispose();
    _bmrController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);
    final width = responsive.width;
    final height = responsive.height;
    final horizontalPadding = responsive.horizontalPadding();
    final fieldSpacing = responsive.heightPercent(0.015);
    final titleFontSize = responsive.fontSize(30);
    final buttonFontSize = responsive.fontSize(18);
    final buttonWidth = responsive.widthPercent(0.85);
    final buttonHeight = responsive.buttonHeight(60);
    final cameraButtonSize = responsive.isTablet
        ? 100.0
        : responsive.widthPercent(0.17);
    final iconSize = responsive.iconSize(30);

    return BlocConsumer<ManualAssessmentCubit, ManualAssessmentState>(
      listener: (context, state) async {
        if (state is ManualAssessmentFailure) {
          CustomErrorSnackBar.show(context, state.error);
        } else if (state is ManualAssessmentSuccess) {
          final localStorage = LocalStorageService();
          await localStorage.setBodyDataCompleted(true);
          await localStorage.savePendingProfileData(
            weight: _weightController.text.trim(),
            height: _heightController.text.trim(),
            gender: _selectedGender,
          );
          if (!context.mounted) return;
          GoRouter.of(context).push(
            AppRouter.kAssessmentOneView,
            extra: {'assessmentId': state.assessmentId ?? 0},
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding * 0.1,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomAssessmentTextWidget(),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: IconButton(
                            color: kPrimaryColor,
                            onPressed: () {
                              GoRouter.of(context).go(AppRouter.kSignUpView);
                            },
                            icon: Icon(Icons.logout, size: iconSize * 1.3),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.01),
                    Text(
                      'Enter your body data',
                      style: Styles.textStyle30.copyWith(
                        fontFamily: 'Work Sans',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: titleFontSize,
                      ),
                    ),
                    SizedBox(height: height * 0.015),
                    CustomRowTextWidget(textLeft: 'Age', textRight: 'Gender'),
                    _BodyDataRow(
                      width: width,
                      children: [
                        BodyDataInputField(
                          controller: _ageController,
                          width: width * 0.15,
                        ),
                        BodyDataGenderSelector(
                          selectedGender: _selectedGender,
                          onGenderChanged: (gender) =>
                              setState(() => _selectedGender = gender),
                          width: width * 0.45,
                        ),
                      ],
                    ),
                    SizedBox(height: fieldSpacing),
                    CustomRowTextWidget(
                      textLeft: 'Weight',
                      textRight: 'Height',
                    ),
                    _BodyDataRow(
                      width: width,
                      children: [
                        BodyDataInputWithUnit(
                          controller: _weightController,
                          units: ['Kg', 'lbs'],
                          selectedUnit: _weightUnit,
                          onUnitChanged: (unit) =>
                              setState(() => _weightUnit = unit),
                          width: width * 0.45,
                        ),
                        BodyDataInputWithUnit(
                          controller: _heightController,
                          units: ['Cm', 'Fee'],
                          selectedUnit: _heightUnit,
                          onUnitChanged: (unit) =>
                              setState(() => _heightUnit = unit),
                          width: width * 0.4,
                        ),
                      ],
                    ),
                    SizedBox(height: fieldSpacing),
                    CustomRowTextWidget(
                      textLeft: 'Muscle Percetage',
                      textRight: 'Fat Percentage',
                    ),
                    _BodyDataRow(
                      width: width,
                      children: [
                        BodyDataInputWithUnit(
                          controller: _muscleController,
                          units: ['Kg', '%'],
                          selectedUnit: _muscleUnit,
                          onUnitChanged: (unit) =>
                              setState(() => _muscleUnit = unit),
                          width: width * 0.4,
                        ),
                        BodyDataInputWithUnit(
                          controller: _fatController,
                          units: ['Kg', '%'],
                          selectedUnit: _fatUnit,
                          onUnitChanged: (unit) =>
                              setState(() => _fatUnit = unit),
                          width: width * 0.45,
                        ),
                      ],
                    ),
                    SizedBox(height: fieldSpacing),
                    CustomRowTextWidget(
                      textLeft: 'Water Percentage',
                      textRight: 'BMR',
                    ),
                    _BodyDataRow(
                      width: width,
                      children: [
                        BodyDataInputWithUnit(
                          controller: _waterController,
                          units: ['Kg', '%'],
                          selectedUnit: _waterUnit,
                          onUnitChanged: (unit) =>
                              setState(() => _waterUnit = unit),
                          width: width * 0.4,
                        ),
                        BodyDataInputWithUnit(
                          controller: _bmrController,
                          units: ['Kg', '%'],
                          selectedUnit: _bmrUnit,
                          onUnitChanged: (unit) =>
                              setState(() => _bmrUnit = unit),
                          width: width * 0.45,
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.04),
                    Center(
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: cameraButtonSize,
                          height: cameraButtonSize,
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.black,
                            size: iconSize,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.03),
                    Center(
                      child: state is ManualAssessmentLoading
                          ? const CircularProgressIndicator()
                          : CustomButton(
                              text: 'Continue',
                              width: buttonWidth,
                              height: buttonHeight,
                              style: Styles.textStyle18.copyWith(
                                fontFamily: 'Work Sans',
                                color: Colors.white,
                                fontSize: buttonFontSize,
                              ),
                              radius: 19,
                              icon: Icons.arrow_forward,
                              onTap: _onContinuePressed,
                            ),
                    ),
                    SizedBox(height: height * 0.02),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _onContinuePressed() {
    final ageText = _ageController.text.trim();
    final weightText = _normalizeDecimalText(_weightController.text);
    final heightText = _normalizeDecimalText(_heightController.text);
    final muscleText = _normalizeDecimalText(_muscleController.text);
    final fatText = _normalizeDecimalText(_fatController.text);
    final waterText = _normalizeDecimalText(_waterController.text);
    final bmrText = _normalizeDecimalText(_bmrController.text);

    if (ageText.isEmpty ||
        weightText.isEmpty ||
        heightText.isEmpty ||
        muscleText.isEmpty ||
        fatText.isEmpty ||
        waterText.isEmpty ||
        bmrText.isEmpty) {
      CustomErrorSnackBar.show(context, 'Please fill in all fields');
      return;
    }

    final age = int.tryParse(ageText);
    final weight = double.tryParse(weightText);
    final height = double.tryParse(heightText);
    final muscle = double.tryParse(muscleText);
    final fat = double.tryParse(fatText);
    final water = double.tryParse(waterText);
    final bmr = double.tryParse(bmrText);

    if (age == null ||
        weight == null ||
        height == null ||
        muscle == null ||
        fat == null ||
        water == null ||
        bmr == null) {
      CustomErrorSnackBar.show(
        context,
        'Please enter valid numbers (use a dot for decimals, e.g. 74.5)',
      );
      return;
    }

    final request = ManualAssessmentRequestModel(
      age: age,
      gender: _selectedGender.toLowerCase(),
      weight: weight,
      height: height,
      musclePercentage: muscle,
      fatPercentage: fat,
      waterPercentage: water,
      bmr: bmr,
    );
    log('📤 REQUEST: ${request.toJson()}');

    context.read<ManualAssessmentCubit>().submitManualAssessment(
      request: request,
    );
  }

  /// Trims and accepts comma as decimal separator (locales often use `,`).
  static String _normalizeDecimalText(String raw) {
    return raw.trim().replaceAll(',', '.');
  }
}

class _BodyDataRow extends StatelessWidget {
  const _BodyDataRow({required this.width, required this.children});

  final double width;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: Row(
        children: [
          Expanded(child: children[0]),
          SizedBox(width: width * 0.08),
          Expanded(child: children[1]),
        ],
      ),
    );
  }
}
