import 'package:move_on/features/chat/Presentation/views/chat_bot_view.dart';
import 'package:move_on/features/home/presentation/views/home_view.dart';
import 'package:move_on/features/home/presentation/views/progress_tracking_view.dart';
import 'package:move_on/features/information/presentation/views/assessment_one_view.dart';
import 'package:move_on/features/information/presentation/views/assessment_three_view.dart';
import 'package:move_on/features/information/presentation/views/assessment_two_view.dart';
import 'package:move_on/features/nutrition/presentation/views/meal_ideas_view.dart';
import 'package:move_on/features/nutrition/presentation/views/recipe_detail_view.dart';
import 'package:move_on/features/nutrition/presentation/views/nutrition_get_started_view.dart';
import 'package:move_on/features/profile/presentation/edit_profile_view.dart';
import 'package:move_on/features/profile/presentation/views/notification_settings_view.dart';
import 'package:move_on/features/profile/presentation/views/password_settings_view.dart';
import 'package:move_on/features/profile/presentation/views/profile_view.dart';
import 'package:move_on/features/profile/presentation/views/settings_view.dart';
import 'package:move_on/features/authentication/presentation/views/forget_password_view.dart';
import 'package:move_on/features/authentication/presentation/views/reset_password_view.dart';
import 'package:move_on/features/authentication/presentation/views/sign_up_view.dart';
import 'package:move_on/features/splash/presentation/views/quote_view.dart';
import 'package:move_on/features/splash/presentation/views/splash_view.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/features/welcome/presentation/views/fifth_welcome_view.dart';
import 'package:move_on/features/welcome/presentation/views/first_welcome_view.dart';
import 'package:move_on/features/welcome/presentation/views/fourth_welcome_view.dart';
import 'package:move_on/features/welcome/presentation/views/get_started_view.dart';
import 'package:move_on/features/welcome/presentation/views/second_welcome_view.dart';
import 'package:move_on/features/authentication/presentation/views/sign_in_view.dart';
import 'package:move_on/features/welcome/presentation/views/third_welcome_view.dart';
import 'package:move_on/features/workout/presentation/views/about_workout_view.dart';
import 'package:move_on/features/workout/presentation/views/workout_plan_view.dart';
import 'package:move_on/features/workout/presentation/views/workout_video_view.dart';
import 'package:move_on/features/body_data/presentation/views/body_data_view.dart';
import 'package:move_on/features/information/data/models/workout_day_model.dart';
import 'package:move_on/features/information/data/models/workout_excersice_model.dart';
import 'package:move_on/features/information/data/models/workout_plan_model.dart';
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
  static const kResetPasswordView = '/resetPasswordView';
  static const kAssessmentOneView = '/assessmentOneView';
  static const kAssessmentTwoView = '/assessmentTwoView';
  static const kAssessmentThreeView = '/assessmentThreeView';
  static const kWorkoutDetailsView = '/workoutDetailsView';
  static const kAboutWorkoutView = '/aboutWorkoutView';
  static const kWorkoutPlanView = '/workoutPlanView';
  static const kWorkoutVideoView = '/workoutVideoView';
  static const kBodyDataView = '/bodyDataView';
  static const kProfileView = '/profileView';
  static const kEditProfileView = '/editProfileView';
  static const kSettingsView = '/settingsView';
  static const kNotificationSettingsView = '/notificationSettingsView';
  static const kPasswordSettingsView = '/passwordSettingsView';
  static const kHomeView = '/homeView';
  static const kProgressTrackingView = '/progressTrackingView';
  static const kNutritionGetStartedView = '/nutritionGetStartedView';
  static const kMealIdeasView = '/mealIdeasView';
  static const kRecipeDetailView = '/recipeDetail';
  static const kChatBotView = '/chatBotView';

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
        path: kResetPasswordView,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return ResetPasswordView(
            email: extra?['email']?.toString() ?? '',
            initialToken: extra?['token']?.toString(),
            forgotPasswordSentMessage: extra?['sentMessage']?.toString(),
          );
        },
      ),
      GoRoute(
        path: kAssessmentOneView,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          int parseInt(dynamic value, [int fallback = 0]) {
            if (value is int) return value;
            if (value is String) return int.tryParse(value) ?? fallback;
            return fallback;
          }

          final assessmentId = parseInt(extra?['assessmentId']);
          return AssessmentOneView(assessmentId: assessmentId);
        },
      ),
      GoRoute(
        path: kAssessmentTwoView,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          int parseInt(dynamic value, [int fallback = 0]) {
            if (value is int) return value;
            if (value is String) return int.tryParse(value) ?? fallback;
            return fallback;
          }

          final assessmentId = parseInt(extra?['assessmentId']);
          final activityLevel = parseInt(extra?['activityLevel']);
          return AssessmentTwoView(
            assessmentId: assessmentId,
            activityLevel: activityLevel,
          );
        },
      ),
      GoRoute(
        path: kAssessmentThreeView,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          int parseInt(dynamic value, [int fallback = 0]) {
            if (value is int) return value;
            if (value is String) return int.tryParse(value) ?? fallback;
            return fallback;
          }

          final assessmentId = parseInt(extra?['assessmentId']);
          final activityLevel = parseInt(extra?['activityLevel']);
          final goal = (extra?['goal']?.toString() ?? '');
          return AssessmentThreeView(
            assessmentId: assessmentId,
            activityLevel: activityLevel,
            goal: goal,
          );
        },
      ),

      GoRoute(
        path: kWorkoutPlanView,
        builder: (context, state) {
          if (state.extra is WorkoutPlan) {
            return WorkoutPlanView(workoutPlan: state.extra! as WorkoutPlan);
          }
          return const WorkoutPlanLoaderView();
        },
      ),
      GoRoute(
        path: kWorkoutDetailsView,
        builder: (context, state) => WorkoutDetailsView(
          day: state.extra is WorkoutDay
              ? state.extra! as WorkoutDay
              : const WorkoutDay(
                  dayKey: '',
                  dayType: '',
                  dayImageUrl: '',
                  variations: {},
                  exercises: [],
                ),
        ),
      ),
      GoRoute(
        path: kAboutWorkoutView,
        builder: (context, state) {
          final extra = state.extra;
          if (extra is Map<String, dynamic>) {
            return AboutWorkoutView(
              dayType: extra['dayType']?.toString() ?? '',
              exercise: extra['exercise'] is WorkoutExercise
                  ? extra['exercise'] as WorkoutExercise
                  : const WorkoutExercise(
                      exerciseName: '',
                      muscleGroup: '',
                      exerciseType: '',
                      sets: 0,
                      reps: '',
                      description: '',
                      imageUrl: '',
                      videoUrl: '',
                      duration: '',
                      calories: 0,
                    ),
            );
          }
          return const AboutWorkoutView(
            dayType: '',
            exercise: WorkoutExercise(
              exerciseName: '',
              muscleGroup: '',
              exerciseType: '',
              sets: 0,
              reps: '',
              description: '',
              imageUrl: '',
              videoUrl: '',
              duration: '',
              calories: 0,
            ),
          );
        },
      ),
      GoRoute(
        path: kWorkoutVideoView,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return WorkoutVideoView(
            videoUrl: extra?['videoUrl']?.toString() ?? '',
            title: extra?['title']?.toString() ?? 'Exercise Video',
          );
        },
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
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return EditProfileView(
            firstTimeSetup: (extra?['firstTimeSetup'] as bool?) ?? false,
            initialName: extra?['fullName']?.toString(),
            initialEmail: extra?['email']?.toString(),
            initialMobileNumber: extra?['mobileNumber']?.toString(),
            initialDateOfBirth: extra?['dateOfBirth']?.toString(),
            initialWeight: extra?['weight']?.toString(),
            initialHeight: extra?['height']?.toString(),
            initialProfileImageUrl: extra?['profileImageUrl']?.toString(),
          );
        },
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
        path: kMealIdeasView,
        builder: (context, state) => const MealIdeasView(),
      ),
      GoRoute(
        path: kRecipeDetailView,
        builder: (context, state) =>
            RecipeDetailView(recipeData: state.extra as Map<String, dynamic>?),
      ),
      GoRoute(
        path: kChatBotView,
        builder: (context, state) => const ChatBotView(),
      ),
    ],
  );
}
