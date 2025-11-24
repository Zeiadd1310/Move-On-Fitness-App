import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:move_on/core/utils/functions/assets.dart';

class QuoteViewBody extends StatelessWidget {
  const QuoteViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        Colors.black.withOpacity(0.29),
        BlendMode.color,
      ),
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
        child: Image.asset(
          AssetsData.quoteBackground,
          height: 1000,
          fit: BoxFit.fitHeight,
          // alignment: AlignmentGeometry.xy(0.5, 0),
        ),
      ),
    );
  }
}
