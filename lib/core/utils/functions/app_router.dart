import 'package:move_on/features/splash/presentation/views/quote_view.dart';
import 'package:move_on/features/splash/presentation/views/splash_view.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const kQuoteView = '/quoteView';
  static const kHomeView = '/homeView';

  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashView()),
      GoRoute(path: kQuoteView, builder: (context, state) => QuoteView()),
      // GoRoute(path: kHomeView, builder: (context, state) => const HomeView()),
    ],
  );
}
