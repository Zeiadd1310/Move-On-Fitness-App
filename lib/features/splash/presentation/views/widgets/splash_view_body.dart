import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:move_on/core/utils/functions/assets.dart';
import 'package:move_on/core/utils/functions/styles.dart';

import '../../../../../core/utils/functions/app_router.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  _SplashAnimations? _animations;

  @override
  void initState() {
    super.initState();
    initSlidingAnimation();
    _navigateToQuote();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final animations = _animations;
    if (animations == null) {
      return const SizedBox.shrink();
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        _SplashBackground(opacity: animations.bgFade),

        Center(
          child: _SplashContent(
            logoSlide: animations.logoSlide,
            logoFade: animations.logoFade,
            logoScale: animations.logoScale,
            textSlide: animations.textSlide,
            textFade: animations.textFade,
            textScale: animations.textScale,
          ),
        ),
      ],
    );
  }

  void initSlidingAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    );
    _animations = _SplashAnimations(
      bgFade: CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.45, curve: Curves.easeInOut),
      ),
      logoSlide: Tween<Offset>(begin: const Offset(0, 0.7), end: Offset.zero)
          .animate(
            CurvedAnimation(
              parent: _animationController,
              curve: const Interval(0.45, 0.80, curve: Curves.easeOutCubic),
            ),
          ),
      logoFade: CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.45, 0.80, curve: Curves.easeIn),
      ),
      logoScale: Tween<double>(begin: 0.88, end: 1.0).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: const Interval(0.45, 0.80, curve: Curves.easeOutBack),
        ),
      ),
      textSlide: Tween<Offset>(begin: const Offset(0, 0.40), end: Offset.zero)
          .animate(
            CurvedAnimation(
              parent: _animationController,
              curve: const Interval(0.80, 1.0, curve: Curves.easeOutCubic),
            ),
          ),
      textFade: CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.80, 1.0, curve: Curves.easeIn),
      ),
      textScale: Tween<double>(begin: 0.95, end: 1.0).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: const Interval(0.80, 1.0, curve: Curves.easeOutQuad),
        ),
      ),
    );
    _animationController.forward();
  }

  void _navigateToQuote() {
    Future.delayed(const Duration(seconds: 5), () {
      if (!mounted) return;
      GoRouter.of(context).push(AppRouter.kQuoteView);
    });
  }
}

class _SplashBackground extends StatelessWidget {
  const _SplashBackground({required this.opacity});

  final Animation<double> opacity;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: opacity,
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(
          Colors.black.withOpacity(0.4),
          BlendMode.darken,
        ),
        child: ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 0.1, sigmaY: 0.1),
          child: Image.asset(
            AssetsData.splashBackground,
            fit: BoxFit.cover,
            alignment: AlignmentGeometry.xy(0.5, 0),
          ),
        ),
      ),
    );
  }
}

class _SplashContent extends StatelessWidget {
  const _SplashContent({
    required this.logoSlide,
    required this.logoFade,
    required this.logoScale,
    required this.textSlide,
    required this.textFade,
    required this.textScale,
  });

  final Animation<Offset> logoSlide;
  final Animation<double> logoFade;
  final Animation<double> logoScale;
  final Animation<Offset> textSlide;
  final Animation<double> textFade;
  final Animation<double> textScale;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FadeTransition(
          opacity: logoFade,
          child: SlideTransition(
            position: logoSlide,
            child: ScaleTransition(
              scale: logoScale,
              child: Image.asset(AssetsData.logo, width: 275),
            ),
          ),
        ),
        const SizedBox(height: 12),
        FadeTransition(
          opacity: textFade,
          child: SlideTransition(
            position: textSlide,
            child: ScaleTransition(
              scale: textScale,
              child: Column(
                children: [
                  Text(
                    "Your personal AI fitness coach.",
                    style: GoogleFonts.workSans(
                      textStyle: Styles.textStyle18.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SplashAnimations {
  const _SplashAnimations({
    required this.bgFade,
    required this.logoSlide,
    required this.logoFade,
    required this.logoScale,
    required this.textSlide,
    required this.textFade,
    required this.textScale,
  });

  final Animation<double> bgFade;
  final Animation<Offset> logoSlide;
  final Animation<double> logoFade;
  final Animation<double> logoScale;
  final Animation<Offset> textSlide;
  final Animation<double> textFade;
  final Animation<double> textScale;
}
