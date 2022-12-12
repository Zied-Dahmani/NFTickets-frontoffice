import 'package:flutter/material.dart';
import 'package:nftickets/presentation/screens/on_boarding_screen.dart';
import 'package:nftickets/presentation/screens/sign_in_screen.dart';
import 'routes.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    final Object? key = settings.arguments;

    switch (settings.name) {
      case AppRoutes.onBoardingScreen:
        return MaterialPageRoute(
          builder: (_) => const OnBoardingScreen(),
        );

      case AppRoutes.signInScreen:
        return MaterialPageRoute(
          builder: (_) => SignInScreen(),
        );

      default:
        return null;
    }
  }
}
