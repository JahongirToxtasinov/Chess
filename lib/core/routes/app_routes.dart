import 'package:chess/core/pages/coming_soon.dart';
import 'package:chess/features/pages/playing_modes/two_player.dart';
import 'package:flutter/material.dart';

import '../../constants/routes.dart';
import '../../features/presentation/home_screen.dart';
import '../functions/app_functions.dart';
import '../pages/error.dart';
import '../pages/onboarding.dart';
import '../pages/splash.dart';

class AppRouter {
  static Route<dynamic> router(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return fade(const TwoPlayerMode());
      case AppRoutes.onboarding:
        return fade(const OnboardingScreen());
      case AppRoutes.home:
        return fade(const MainScreen());
      case AppRoutes.comingSoon:
        return fade(const ComingSoon());
      case AppRoutes.twoPlayerMode:
        return fade(const TwoPlayerMode());
      default:
        return fade(const ErrorScreen());
    }
  }
}
