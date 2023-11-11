import 'package:flutter_guitar/guitar_play/presentation/views/guitar_play_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:reg_page/reg_page.dart';

// GoRouter configuration
final router = GoRouter(
  routes: [

    GoRoute(
      path: '/',
      builder: (context, state) => SplashScreen(yearlySubscriptionId: "12321", monthlySubscriptionId: "112124", nextPage: ()=> const GuitarPlayScreen()),
    ),
    // GoRoute(
    //   path: '/guitar',
    //   builder: (context, state) => const GuitarPlayScreen(),
    // ),
  ],
);
