import 'package:move_on/features/information/presentation/views/assessment_one_view.dart';
import 'package:move_on/features/sign/presentation/views/forget_password_view.dart';
import 'package:move_on/features/sign/presentation/views/sign_up_view.dart';
import 'package:move_on/features/splash/presentation/views/quote_view.dart';
import 'package:move_on/features/splash/presentation/views/splash_view.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/features/welcome/presentation/views/fifth_welcome_view.dart';
import 'package:move_on/features/welcome/presentation/views/first_welcome_view.dart';
import 'package:move_on/features/welcome/presentation/views/fourth_welcome_view.dart';
import 'package:move_on/features/welcome/presentation/views/get_started_view.dart';
import 'package:move_on/features/welcome/presentation/views/second_welcome_view.dart';
import 'package:move_on/features/sign/presentation/views/sign_in_view.dart';
import 'package:move_on/features/welcome/presentation/views/third_welcome_view.dart';

abstract class AppRouter {
  static const kQuoteView = '/quoteView';
  static const kGetStartedView = '/getStartedView';
  static const kFirstWelcome = '/firstWelcome';
  static const kSecondWelcome = '/secondWelcome';
  static const kThirdWelcome = '/thirdWelcome';
  static const kFourthWelcome = '/fourthWelcome';
  static const kFifthWelcome = '/fifthWelcome';
  static const kSignUpView = '/signUpView';
  static const kSignInView = '/signInView';
  static const kForgetPasswordView = '/forgetPasswordView';
  static const kAssessmentOneView = '/assessmentOneView';
  static const kAssessmentTwoView = '/assessmentTwoView';
  static const kAssessmentThreeView = '/assessmentThreeView';

  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashView()),
      GoRoute(path: kQuoteView, builder: (context, state) => QuoteView()),
      GoRoute(
        path: kGetStartedView,
        builder: (context, state) => GetStartedView(),
      ),
      GoRoute(
        path: kFirstWelcome,
        builder: (context, state) => FirstWelcomeView(),
      ),
      GoRoute(
        path: kSecondWelcome,
        builder: (context, state) => SecondWelcomeView(),
      ),
      GoRoute(
        path: kThirdWelcome,
        builder: (context, state) => ThirdWelcomeView(),
      ),
      GoRoute(
        path: kFourthWelcome,
        builder: (context, state) => FourthWelcomeView(),
      ),
      GoRoute(
        path: kFifthWelcome,
        builder: (context, state) => FifthWelcomeView(),
      ),
      GoRoute(
        path: kSignUpView,
        builder: (context, state) => const SignUpView(),
      ),
      GoRoute(
        path: kSignInView,
        builder: (context, state) => const SignInView(),
      ),
      GoRoute(
        path: kForgetPasswordView,
        builder: (context, state) => const ForgetPasswordView(),
      ),
      GoRoute(
        path: kAssessmentOneView,
        builder: (context, state) => const AssessmentOneView(),
      ),
      // GoRoute(
      //   path: kAssessmentTwoView,
      //   builder: (context, state) => const AssessmentTwoView(),
      // ),
      // GoRoute(
      //   path: kAssessmentThreeView,
      //   builder: (context, state) => const AssessmentThreeView(),
      // ),
    ],
  );
}
