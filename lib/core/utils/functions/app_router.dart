import 'package:move_on/features/home/presentation/views/home_view.dart';
import 'package:move_on/features/home/presentation/views/progress_tracking_view.dart';
import 'package:move_on/features/information/presentation/views/assessment_one_view.dart';
import 'package:move_on/features/information/presentation/views/assessment_three_view.dart';
import 'package:move_on/features/information/presentation/views/assessment_two_view.dart';
import 'package:move_on/features/nutrition/presentation/views/breakfast_view.dart';
import 'package:move_on/features/nutrition/presentation/views/dinner_view.dart';
import 'package:move_on/features/nutrition/presentation/views/lunch_view.dart';
import 'package:move_on/features/nutrition/presentation/views/nutrition_get_started_view.dart';
import 'package:move_on/features/profile/presentation/edit_profile_view.dart';
import 'package:move_on/features/profile/presentation/views/notification_settings_view.dart';
import 'package:move_on/features/profile/presentation/views/password_settings_view.dart';
import 'package:move_on/features/profile/presentation/views/profile_view.dart';
import 'package:move_on/features/profile/presentation/views/settings_view.dart';
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
import 'package:move_on/features/workout/presentation/views/about_workout_view.dart';
import 'package:move_on/features/workout/presentation/views/body_data_view.dart';
import 'package:move_on/features/workout/presentation/views/five_days_view.dart';
import 'package:move_on/features/workout/presentation/views/four_days_view.dart';
import 'package:move_on/features/workout/presentation/views/one_day_view.dart';
import 'package:move_on/features/workout/presentation/views/three_days_view.dart';
import 'package:move_on/features/workout/presentation/views/two_days_view.dart';
import 'package:move_on/features/workout/presentation/views/workout_details_view.dart';

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
  static const kOneDayView = '/oneDayView';
  static const kTwoDaysView = '/twoDaysView';
  static const kThreeDaysView = '/threeDaysView';
  static const kFourDaysView = '/fourDaysView';
  static const kFiveDaysView = '/fiveDaysView';
  static const kWorkoutDetailsView = '/workoutDetailsView';
  static const kAboutWorkoutView = '/aboutWorkoutView';
  static const kBodyDataView = '/bodyDataView';
  static const kProfileView = '/profileView';
  static const kEditProfileView = '/editProfileView';
  static const kSettingsView = '/settingsView';
  static const kNotificationSettingsView = '/notificationSettingsView';
  static const kPasswordSettingsView = '/passwordSettingsView';
  static const kHomeView = '/homeView';
  static const kProgressTrackingView = '/progressTrackingView';
  static const kNutritionGetStartedView = '/nutritionGetStartedView';
  static const kBreakfastView = '/kBreakfastView';
  static const kLunchView = '/kLunchView';
  static const kDinnerView = '/kDinnerView';

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
      GoRoute(
        path: kAssessmentTwoView,
        builder: (context, state) => const AssessmentTwoView(),
      ),
      GoRoute(
        path: kAssessmentThreeView,
        builder: (context, state) => const AssessmentThreeView(),
      ),
      GoRoute(
        path: kOneDayView,
        builder: (context, state) => const OneDayView(),
      ),
      GoRoute(
        path: kTwoDaysView,
        builder: (context, state) => const TwoDaysView(),
      ),
      GoRoute(
        path: kThreeDaysView,
        builder: (context, state) => const ThreeDaysView(),
      ),
      GoRoute(
        path: kFourDaysView,
        builder: (context, state) => const FourDaysView(),
      ),
      GoRoute(
        path: kFiveDaysView,
        builder: (context, state) => const FiveDaysView(),
      ),
      GoRoute(
        path: kWorkoutDetailsView,
        builder: (context, state) => const WorkoutDetailsView(),
      ),
      GoRoute(
        path: kAboutWorkoutView,
        builder: (context, state) => const AboutWorkoutView(),
      ),
      GoRoute(
        path: kBodyDataView,
        builder: (context, state) => const BodyDataView(),
      ),
      GoRoute(
        path: kProfileView,
        builder: (context, state) => const ProfileView(),
      ),
      GoRoute(
        path: kEditProfileView,
        builder: (context, state) => const EditProfileView(),
      ),
      GoRoute(
        path: kSettingsView,
        builder: (context, state) => const SettingsView(),
      ),
      GoRoute(
        path: kNotificationSettingsView,
        builder: (context, state) => const NotificationSettingsView(),
      ),
      GoRoute(
        path: kPasswordSettingsView,
        builder: (context, state) => const PasswordSettingsView(),
      ),
      GoRoute(path: kHomeView, builder: (context, state) => const HomeView()),
      GoRoute(
        path: kProgressTrackingView,
        builder: (context, state) => const ProgressTrackingView(),
      ),
      GoRoute(
        path: kNutritionGetStartedView,
        builder: (context, state) => const NutritionGetStartedView(),
      ),
      GoRoute(
        path: kBreakfastView,
        builder: (context, state) => const BreakfastView(),
      ),
      GoRoute(
        path: kDinnerView,
        builder: (context, state) => const DinnerView(),
      ),
      GoRoute(path: kLunchView, builder: (context, state) => const LunchView()),
    ],
  );
}
