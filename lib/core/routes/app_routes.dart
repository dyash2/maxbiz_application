import 'package:flutter/material.dart';
import 'package:maxbazaar/features/auth/presentation/pages/auth_wrapper.dart';
import 'package:maxbazaar/features/auth/presentation/pages/login_page.dart';
import 'package:maxbazaar/features/auth/presentation/pages/splash_page.dart';
import 'package:maxbazaar/features/home/presentation/pages/home_page.dart';

class AppRoutes {
  static const String authWrapper = '/';
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case authWrapper:
        return MaterialPageRoute(builder: (_) => const AuthWrapper());
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}
