import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/constants.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/core/utils/functions/styles.dart';
import 'package:move_on/core/widgets/custom_background_widget.dart';
import 'package:move_on/features/welcome/presentation/views/widgets/custom_button.dart';

class NutritionGetStartedViewBody extends StatelessWidget {
  const NutritionGetStartedViewBody({super.key});

  // #region agent log
  void _log(String hypothesisId, String message, Map<String, dynamic> data) {
    try {
      final logFile = File(
        r'd:\Uni\Graduation\MoveOn\move_on\.cursor\debug.log',
      );
      final logEntry = jsonEncode({
        'id': 'log_${DateTime.now().millisecondsSinceEpoch}',
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'location': 'nutrition_get_started_view_body.dart:build',
        'message': message,
        'data': data,
        'sessionId': 'debug-session',
        'runId': 'run1',
        'hypothesisId': hypothesisId,
      });
      logFile.writeAsStringSync('$logEntry\n', mode: FileMode.append);
    } catch (e) {}
  }
  // #endregion

  @override
  Widget build(BuildContext context) {
    // #region agent log
    final screenSize = MediaQuery.of(context).size;
    _log('A', 'Screen dimensions captured', {
      'width': screenSize.width,
      'height': screenSize.height,
    });
    // #endregion

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 400;
    final isTablet = screenWidth > 600;

    // #region agent log
    _log('B', 'Responsive calculations', {
      'isSmallScreen': isSmallScreen,
      'isTablet': isTablet,
      'calculatedPadding': screenWidth * 0.04,
      'calculatedSpacing': screenHeight * 0.05,
    });
    // #endregion

    // Calculate responsive values
    final horizontalPadding = isSmallScreen
        ? screenWidth * 0.04
        : screenWidth * 0.045;
    final verticalPadding = screenHeight * 0.01;
    final topSpacing =
        screenHeight * 0.52; // Responsive spacing instead of fixed 420
    final contentSpacing =
        screenHeight * 0.045; // Responsive spacing instead of fixed 40
    final iconSize = isSmallScreen ? 24.0 : (isTablet ? 32.0 : 30.0);
    final appleIconSize = isSmallScreen ? 32.0 : (isTablet ? 48.0 : 40.0);
    final buttonWidth = isSmallScreen
        ? screenWidth * 0.75
        : (isTablet ? 320.0 : 280.0);
    final buttonHeight = isSmallScreen ? 55.0 : (isTablet ? 70.0 : 65.0);
    final rowSpacing = isSmallScreen ? 8.0 : 10.0;

    // #region agent log
    _log('C', 'Final responsive values', {
      'horizontalPadding': horizontalPadding,
      'verticalPadding': verticalPadding,
      'topSpacing': topSpacing,
      'contentSpacing': contentSpacing,
      'iconSize': iconSize,
      'appleIconSize': appleIconSize,
      'buttonWidth': buttonWidth,
      'buttonHeight': buttonHeight,
    });
    // #endregion

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          CustomBackgroundWidget(
            imagePath: 'assets/images/nutiration.png',
            alignmentGeometry: AlignmentGeometry.center,
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: verticalPadding,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.pop();
                          },
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: iconSize,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                GoRouter.of(
                                  context,
                                ).push(AppRouter.kNotificationSettingsView);
                              },
                              icon: Icon(Icons.notifications, size: iconSize),
                            ),
                            IconButton(
                              onPressed: () {
                                GoRouter.of(
                                  context,
                                ).push(AppRouter.kProfileView);
                              },
                              icon: Icon(Icons.person, size: iconSize),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: topSpacing),
                    Text(
                      'Nutrition and Diet,Tailored for you.',
                      style: Styles.textStyle36.copyWith(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w900,
                        fontSize: isSmallScreen ? 28 : (isTablet ? 40 : 36),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: contentSpacing),
                    Row(
                      children: [
                        SizedBox(width: rowSpacing),
                        Icon(
                          FontAwesomeIcons.appleWhole,
                          size: appleIconSize,
                          color: kPrimaryColor,
                        ),
                        SizedBox(width: rowSpacing),
                        Expanded(
                          child: Text(
                            'Say goodbye to manual nutrition.\nAI nutritions here for you !',
                            style: Styles.textStyle18.copyWith(
                              fontFamily: 'Work Sans',
                              fontWeight: FontWeight.w500,
                              fontSize: isSmallScreen
                                  ? 16
                                  : (isTablet ? 20 : 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: contentSpacing),
                    CustomButton(
                      text: 'Know Your Plan',
                      width: buttonWidth,
                      height: buttonHeight,
                      style: Styles.textStyle18.copyWith(
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Work Sans',
                        fontSize: isSmallScreen ? 16 : (isTablet ? 20 : 18),
                      ),
                      radius: 40,
                      onTap: () {
                        GoRouter.of(context).push(AppRouter.kBreakfastView);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
