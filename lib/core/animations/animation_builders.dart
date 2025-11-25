import 'package:flutter/animation.dart';

/// Helper to create a fade animation using a curved interval.
Animation<double> buildFadeAnimation({
  required AnimationController controller,
  required double start,
  required double end,
  Curve curve = Curves.easeIn,
}) {
  return CurvedAnimation(
    parent: controller,
    curve: Interval(start, end, curve: curve),
  );
}

/// Helper to create a slide animation driven by an interval.
Animation<Offset> buildSlideAnimation({
  required AnimationController controller,
  required double start,
  required double end,
  Offset begin = const Offset(0, 0.4),
  Offset finish = Offset.zero,
  Curve curve = Curves.easeOutCubic,
}) {
  return Tween<Offset>(begin: begin, end: finish).animate(
    CurvedAnimation(
      parent: controller,
      curve: Interval(start, end, curve: curve),
    ),
  );
}

/// Helper to create a scale animation using a curved interval.
Animation<double> buildScaleAnimation({
  required AnimationController controller,
  required double start,
  required double end,
  double begin = 0.9,
  double finish = 1.0,
  Curve curve = Curves.easeOutBack,
}) {
  return Tween<double>(begin: begin, end: finish).animate(
    CurvedAnimation(
      parent: controller,
      curve: Interval(start, end, curve: curve),
    ),
  );
}
