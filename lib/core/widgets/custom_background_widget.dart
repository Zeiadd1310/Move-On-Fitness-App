import 'dart:ui';

import 'package:flutter/material.dart';

class CustomBackgroundWidget extends StatelessWidget {
  const CustomBackgroundWidget({
    super.key,
    required this.imagePath,
    this.fit = BoxFit.cover,
    required this.alignmentGeometry,
  });

  final String imagePath;
  final BoxFit fit;
  final AlignmentGeometry alignmentGeometry;

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 0.1, sigmaY: 0.1),
      child: Image.asset(imagePath, fit: fit, alignment: alignmentGeometry),
    );
  }
}
