import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:move_on/constants.dart';
import 'package:move_on/core/utils/functions/assets.dart';
import 'package:move_on/core/utils/functions/styles.dart';

class QuoteViewBody extends StatelessWidget {
  const QuoteViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);
    final double iconSize = screenSize.width * 0.19;
    final double verticalSpacing = screenSize.height * 0.08;

    return Stack(
      children: [
        Image.asset(
          AssetsData.quoteBackground,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Align(
          alignment: const Alignment(0, 0.7),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: iconSize,
                  height: iconSize,
                  decoration: const BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.format_quote,
                      color: Colors.white,
                      size: iconSize * 0.45,
                    ),
                  ),
                ),
                SizedBox(height: verticalSpacing),
                Text(
                  '"Remember, physical fitness can neither be acquired by wishful thinking nor by outright purchase.”',
                  style: GoogleFonts.workSans(
                    textStyle: Styles.textStyle24.copyWith(color: Colors.white),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: verticalSpacing),
                Text(
                  '- Joseph Pilates',
                  style: GoogleFonts.workSans(
                    textStyle: Styles.textStyle18.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
