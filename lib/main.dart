import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:move_on/core/utils/functions/app_router.dart' show AppRouter;

void main() {
  runApp(const MoveOn());
}

class MoveOn extends StatelessWidget {
  const MoveOn({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        textTheme: GoogleFonts.poppinsTextTheme().apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
      ),
    );
  }
}
