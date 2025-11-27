import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:move_on/core/animations/animation_builders.dart';
import 'package:move_on/constants.dart';
import 'package:move_on/core/utils/functions/assets.dart';
import 'package:move_on/core/utils/functions/styles.dart';
import '../../../../../core/utils/functions/app_router.dart';

class QuoteViewBody extends StatefulWidget {
  const QuoteViewBody({super.key});

  @override
  State<QuoteViewBody> createState() => _QuoteViewBodyState();
}

class _QuoteViewBodyState extends State<QuoteViewBody>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final _QuoteAnimations _animations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    );
    _animations = _QuoteAnimations(
      iconFade: buildFadeAnimation(
        controller: _controller,
        start: 0.06,
        end: 0.45,
      ),
      iconSlide: buildSlideAnimation(
        controller: _controller,
        start: 0.1,
        end: 0.45,
        begin: const Offset(0, 0.35),
      ),
      iconScale: buildScaleAnimation(
        controller: _controller,
        start: 0.05,
        end: 0.45,
        begin: 0.88,
      ),
      quoteFade: buildFadeAnimation(
        controller: _controller,
        start: 0.35,
        end: 0.8,
      ),
      quoteSlide: buildSlideAnimation(
        controller: _controller,
        start: 0.35,
        end: 0.8,
        begin: const Offset(0, 0.4),
      ),
      authorFade: buildFadeAnimation(
        controller: _controller,
        start: 0.6,
        end: 1,
      ),
      authorSlide: buildSlideAnimation(
        controller: _controller,
        start: 0.6,
        end: 1,
        begin: const Offset(0, 0.35),
      ),
    );
    _controller.forward();
    _navigateToGetStarted();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToGetStarted() {
    Future.delayed(const Duration(seconds: 6), () {
      if (!mounted) return;
      GoRouter.of(context).push(AppRouter.kGetStartedView);
    });
  }

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
            child: _QuoteAnimatedContent(
              iconSize: iconSize,
              verticalSpacing: verticalSpacing,
              animations: _animations,
            ),
          ),
        ),
      ],
    );
  }
}

class _QuoteAnimatedContent extends StatelessWidget {
  const _QuoteAnimatedContent({
    required this.iconSize,
    required this.verticalSpacing,
    required this.animations,
  });

  final double iconSize;
  final double verticalSpacing;
  final _QuoteAnimations animations;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FadeTransition(
          opacity: animations.iconFade,
          child: SlideTransition(
            position: animations.iconSlide,
            child: ScaleTransition(
              scale: animations.iconScale,
              child: Container(
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
            ),
          ),
        ),
        SizedBox(height: verticalSpacing),
        FadeTransition(
          opacity: animations.quoteFade,
          child: SlideTransition(
            position: animations.quoteSlide,
            child: Text(
              '"Remember, physical fitness can neither be acquired by wishful thinking nor by outright purchase."',
              style: GoogleFonts.workSans(textStyle: Styles.textStyle24),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(height: verticalSpacing),
        FadeTransition(
          opacity: animations.authorFade,
          child: SlideTransition(
            position: animations.authorSlide,
            child: Text(
              '- Joseph Pilates',
              style: GoogleFonts.workSans(
                textStyle: Styles.textStyle18.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _QuoteAnimations {
  const _QuoteAnimations({
    required this.iconFade,
    required this.iconSlide,
    required this.iconScale,
    required this.quoteFade,
    required this.quoteSlide,
    required this.authorFade,
    required this.authorSlide,
  });

  final Animation<double> iconFade;
  final Animation<Offset> iconSlide;
  final Animation<double> iconScale;
  final Animation<double> quoteFade;
  final Animation<Offset> quoteSlide;
  final Animation<double> authorFade;
  final Animation<Offset> authorSlide;
}
