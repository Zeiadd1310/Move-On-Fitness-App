import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/constants.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/core/utils/functions/styles.dart';
import 'package:move_on/features/welcome/presentation/views/widgets/body_data_input_with_unit.dart';
import 'package:move_on/features/welcome/presentation/views/widgets/custom_button.dart';
import 'package:move_on/features/workout/presentation/views/widgets/body_data_gender_selector.dart';
import 'package:move_on/features/workout/presentation/views/widgets/body_data_input_field.dart';
import 'package:move_on/features/workout/presentation/views/widgets/custom_assessment_text_widget.dart';
import 'package:move_on/features/workout/presentation/views/widgets/custom_row_text_widget.dart';

class BodyDataViewBody extends StatefulWidget {
  const BodyDataViewBody({super.key});

  @override
  State<BodyDataViewBody> createState() => _BodyDataViewBodyState();
}

class _BodyDataViewBodyState extends State<BodyDataViewBody> {
  // Controllers
  final TextEditingController _ageController = TextEditingController(text: '0');
  final TextEditingController _weightController = TextEditingController(
    text: '0',
  );
  final TextEditingController _heightController = TextEditingController(
    text: '0',
  );
  final TextEditingController _muscleController = TextEditingController(
    text: '0',
  );
  final TextEditingController _fatController = TextEditingController(text: '0');
  final TextEditingController _waterController = TextEditingController(
    text: '0',
  );
  final TextEditingController _bmrController = TextEditingController(text: '0');

  String _selectedGender = 'Male';
  String _weightUnit = 'Kg';
  String _heightUnit = 'Cm';
  String _muscleUnit = 'Kg';
  String _fatUnit = 'Kg';
  String _waterUnit = 'Kg';
  String _bmrUnit = 'Kg';

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
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    final isTablet = width > 600;
    final horizontalPadding = isTablet ? width * 0.1 : width * 0.03;
    final fieldSpacing = height * 0.015;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CustomAssessmentTextWidget(),
                SizedBox(height: height * 0.01),
                Text(
                  'Enter your body data',
                  style: Styles.textStyle30.copyWith(
                    fontFamily: 'Work Sans',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
                CustomRowTextWidget(textLeft: 'Weight', textRight: 'Height'),
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
                      onUnitChanged: (unit) => setState(() => _fatUnit = unit),
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
                      onUnitChanged: (unit) => setState(() => _bmrUnit = unit),
                      width: width * 0.45,
                    ),
                  ],
                ),
                SizedBox(height: height * 0.04),
                Center(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: isTablet ? 100 : width * 0.17,
                      height: isTablet ? 100 : width * 0.17,
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.03),
                Center(
                  child: CustomButton(
                    text: 'Continue',
                    width: width * 0.85,
                    height: 60,
                    style: Styles.textStyle18.copyWith(
                      fontFamily: 'Work Sans',
                      color: Colors.white,
                    ),
                    radius: 19,
                    icon: Icons.arrow_forward,
                    onTap: () {
                      GoRouter.of(context).push(AppRouter.kAssessmentOneView);
                    },
                  ),
                ),
                SizedBox(height: height * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
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
