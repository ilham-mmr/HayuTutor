import 'package:flutapp/helpers/noanimation_page_route.dart';
import 'package:flutapp/screens/auth/signin_screen.dart';
import 'package:flutapp/screens/auth/signup_screen.dart';
import 'package:flutapp/screens/home_screen.dart';
import 'package:flutapp/screens/landing_screen.dart';
import 'package:flutapp/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/landing-screen':
        return MaterialPageRoute(builder: (_) => LandingScreen());
      case '/home-screen':
        return NoAnimationMaterialPageRoute(builder: (_) => HomeScreen());
      case '/signup-screen':
        return NoAnimationMaterialPageRoute(builder: (_) => SignupScreen());
      case '/signin-screen':
        return NoAnimationMaterialPageRoute(builder: (_) => SigninScreen());
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
