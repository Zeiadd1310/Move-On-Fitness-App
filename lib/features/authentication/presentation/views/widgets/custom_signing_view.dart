import 'package:flutter/material.dart';
import 'package:move_on/core/utils/functions/assets.dart';
import 'package:move_on/core/utils/functions/styles.dart';

class CustomSigningView extends StatelessWidget {
  const CustomSigningView({
    super.key,
    required this.title,
    required this.subTitle,
  });

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: 314,
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/chestpressdark.png',
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black54,
                          Colors.black,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 100,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Image.asset(AssetsData.logo, width: 86, height: 86),
                  SizedBox(height: 16),
                  Text(
                    title,
                    style: Styles.textStyle30.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    subTitle,
                    style: Styles.textStyle16,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
