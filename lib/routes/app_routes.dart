import 'package:flutter/material.dart';
import 'package:ogo/features/authentication/ui/login_screen_ui.dart';
import 'package:ogo/features/authentication/ui/register_screen_ui.dart';
import 'package:ogo/features/homepage/ui/home_page.dart';
import 'package:ogo/features/authentication/ui/splash_screen.dart';

class AppRoutes {
  static const splash = '/splash';
  static const homepage = '/homepage';

  static const login = '/login';
  static const register = '/register';
  static const test = '/test';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case homepage:
        return MaterialPageRoute(builder: (_) => HomePage());
      case test:
        return MaterialPageRoute(builder: (_) => const Placeholder());
      // case homepage:
      //   return MaterialPageRoute(
      //     builder: (context) => HomePage(),
      //   );

      default:
        //TODO: Make 404 Error Screen or Try Again Screen
        return MaterialPageRoute(builder: (_) => SplashScreen());
    }
  }
}
