import 'package:flutter/material.dart';
import 'package:move_on/constants.dart';

class RecipeImageWithBadge extends StatelessWidget {
  final String imagePath;
  final bool showBadge;
  final Alignment badgePosition;
  final double? containerHeight;
  final double? imageHeight;
  final bool hasPadding;
  final EdgeInsets? padding;

  const RecipeImageWithBadge({
    super.key,
    required this.imagePath,
    this.showBadge = false,
    this.badgePosition = Alignment.topRight,
    this.containerHeight,
    this.imageHeight,
    this.hasPadding = true,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final defaultPadding = hasPadding
        ? (padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 20))
        : EdgeInsets.zero;

    final containerH = containerHeight ?? 275.0;
    final imgH = imageHeight ?? 235.0;

    Widget imageWidget = ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
        imagePath,
        width: double.infinity,
        height: imgH,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          height: imgH,
          color: Colors.grey.shade800,
          child: const Icon(Icons.image, size: 48),
        ),
      ),
    );

    Widget badgeWidget = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: badgePosition == Alignment.topRight
            ? const BorderRadius.only(
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              )
            : const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
      ),
      child: Text(
        'Recipe Of The Day',
        style: TextStyle(
          color: Colors.black,
          fontSize: badgePosition == Alignment.topRight ? 12 : 14,
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins',
        ),
      ),
    );

    Widget stackContent = Stack(
      alignment: badgePosition,
      children: [imageWidget, if (showBadge) badgeWidget],
    );

    if (hasPadding) {
      return Container(
        height: containerH,
        color: kPrimaryColor,
        child: Padding(padding: defaultPadding, child: stackContent),
      );
    } else {
      return Container(
        height: containerH,
        color: kPrimaryColor,
        child: stackContent,
      );
    }
  }
}
