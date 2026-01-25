import 'package:flutter/material.dart';

/// Helper class for responsive design calculations
class ResponsiveHelper {
  final BuildContext context;
  final MediaQueryData mediaQuery;

  ResponsiveHelper(this.context) : mediaQuery = MediaQuery.of(context);

  /// Screen dimensions
  double get width => mediaQuery.size.width;
  double get height => mediaQuery.size.height;

  /// Breakpoints
  bool get isSmallScreen => width < 400;
  bool get isMediumScreen => width >= 400 && width < 600;
  bool get isTablet => width >= 600 && width < 900;
  bool get isDesktop => width >= 900;

  /// Responsive padding
  double horizontalPadding({double? small, double? medium, double? tablet, double? desktop}) {
    if (isSmallScreen) return small ?? width * 0.04;
    if (isMediumScreen) return medium ?? width * 0.045;
    if (isTablet) return tablet ?? width * 0.06;
    return desktop ?? width * 0.08;
  }

  double verticalPadding({double? small, double? medium, double? tablet, double? desktop}) {
    if (isSmallScreen) return small ?? height * 0.02;
    if (isMediumScreen) return medium ?? height * 0.025;
    if (isTablet) return tablet ?? height * 0.03;
    return desktop ?? height * 0.04;
  }

  /// Responsive font sizes
  double fontSize(double baseSize, {double? small, double? medium, double? tablet, double? desktop}) {
    if (isSmallScreen) return small ?? baseSize * 0.85;
    if (isMediumScreen) return medium ?? baseSize;
    if (isTablet) return tablet ?? baseSize * 1.1;
    return desktop ?? baseSize * 1.2;
  }

  /// Responsive icon sizes
  double iconSize(double baseSize, {double? small, double? medium, double? tablet, double? desktop}) {
    if (isSmallScreen) return small ?? baseSize * 0.85;
    if (isMediumScreen) return medium ?? baseSize;
    if (isTablet) return tablet ?? baseSize * 1.2;
    return desktop ?? baseSize * 1.4;
  }

  /// Responsive spacing
  double spacing(double baseSpacing, {double? small, double? medium, double? tablet, double? desktop}) {
    if (isSmallScreen) return small ?? baseSpacing * 0.8;
    if (isMediumScreen) return medium ?? baseSpacing;
    if (isTablet) return tablet ?? baseSpacing * 1.2;
    return desktop ?? baseSpacing * 1.5;
  }

  /// Responsive button dimensions
  double buttonWidth(double baseWidth, {double? small, double? medium, double? tablet, double? desktop}) {
    if (isSmallScreen) return small ?? width * 0.85;
    if (isMediumScreen) return medium ?? baseWidth;
    if (isTablet) return tablet ?? baseWidth * 1.1;
    return desktop ?? baseWidth * 1.2;
  }

  double buttonHeight(double baseHeight, {double? small, double? medium, double? tablet, double? desktop}) {
    if (isSmallScreen) return small ?? baseHeight * 0.9;
    if (isMediumScreen) return medium ?? baseHeight;
    if (isTablet) return tablet ?? baseHeight * 1.1;
    return desktop ?? baseHeight * 1.2;
  }

  /// Responsive image dimensions
  double imageWidth(double baseWidth, {double? small, double? medium, double? tablet, double? desktop}) {
    if (isSmallScreen) return small ?? width * 0.9;
    if (isMediumScreen) return medium ?? baseWidth;
    if (isTablet) return tablet ?? baseWidth * 1.1;
    return desktop ?? baseWidth * 1.2;
  }

  double imageHeight(double baseHeight, {double? small, double? medium, double? tablet, double? desktop}) {
    if (isSmallScreen) return small ?? baseHeight * 0.85;
    if (isMediumScreen) return medium ?? baseHeight;
    if (isTablet) return tablet ?? baseHeight * 1.1;
    return desktop ?? baseHeight * 1.2;
  }

  /// Percentage-based dimensions
  double widthPercent(double percent) => width * percent;
  double heightPercent(double percent) => height * percent;

  /// Clamp values between min and max
  double clamp(double value, double min, double max) {
    if (value < min) return min;
    if (value > max) return max;
    return value;
  }
}
