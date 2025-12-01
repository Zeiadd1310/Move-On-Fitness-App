import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/constants.dart';
import 'package:move_on/core/utils/functions/app_router.dart';
import 'package:move_on/core/utils/functions/styles.dart';

class CustomTextSpanWidget extends StatelessWidget {
  const CustomTextSpanWidget({
    super.key,
    required this.text,
    required this.textSpan,
    required this.route,
  });

  final String text;
  final String textSpan;
  final String route;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, 0.6),
      child: GestureDetector(
        onTap: () {
          GoRouter.of(context).push(route);
        },
        child: Text.rich(
          TextSpan(
            text: text,
            style: Styles.textStyle16,
            children: [
              TextSpan(
                text: textSpan,
                style: Styles.textStyle16.copyWith(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  decorationColor: kPrimaryColor,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
