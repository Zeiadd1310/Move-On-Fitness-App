import 'package:move_on/features/splash/presentation/views/quote_view.dart';
import 'package:move_on/features/splash/presentation/views/splash_view.dart';
import 'package:go_router/go_router.dart';
import 'package:move_on/features/welcome/presentation/get_started_view.dart';
import 'package:move_on/features/welcome/presentation/sign_in_view.dart';

abstract class AppRouter {
  static const kQuoteView = '/quoteView';
  static const kGetStartedView = '/getStartedView';
  static const kSignInView = '/signInView';
  static const kHomeView = '/homeView';

  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashView()),
      GoRoute(path: kQuoteView, builder: (context, state) => QuoteView()),
      GoRoute(
        path: kGetStartedView,
        builder: (context, state) => GetStartedView(),
      ),
      GoRoute(
        path: kSignInView,
        builder: (context, state) => const SignInView(),
      ),
      // GoRoute(path: kHomeView, builder: (context, state) => const HomeView()),
    ],
  );
}
