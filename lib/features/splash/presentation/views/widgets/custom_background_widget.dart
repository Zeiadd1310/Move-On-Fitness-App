import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:move_on/core/utils/functions/assets.dart';

class CustomBackgroundWidget extends StatelessWidget {
  const CustomBackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 0.1, sigmaY: 0.1),
      child: Image.asset(
        AssetsData.splashBackground,
        fit: BoxFit.cover,
        alignment: AlignmentGeometry.xy(0.5, 0),
      ),
    );
  }
}
