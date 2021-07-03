import 'package:flutapp/helpers/noanimation_page_route.dart';
import 'package:flutapp/screens/auth/signin_screen.dart';
import 'package:flutapp/screens/auth/signup_screen.dart';
import 'package:flutapp/screens/detail_screen.dart';
import 'package:flutapp/screens/tutor_sessions/edit_my_session_screen.dart';
import 'package:flutapp/screens/favorite_screen.dart';
import 'package:flutapp/screens/home_screen.dart';
import 'package:flutapp/screens/landing_screen.dart';
import 'package:flutapp/screens/tutor_sessions/my_tutoring_sessions.dart';
import 'package:flutapp/screens/payment_screen.dart';
import 'package:flutapp/screens/see_all_screen.dart';
import 'package:flutapp/screens/sessions_subject_screen.dart';
import 'package:flutapp/screens/splash_screen.dart';
import 'package:flutapp/screens/tutor_sessions/sessions_screen.dart';
import 'package:flutapp/screens/user/user_profile_screen.dart';
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
      case '/payment-screen':
        return NoAnimationMaterialPageRoute(
            builder: (_) => PaymentScreen(
                  tutorSession: args,
                ));
      case '/userprofile-screen':
        return NoAnimationMaterialPageRoute(
            builder: (_) => UserProfileScreen());
      case '/search-sessions-screen':
        return NoAnimationMaterialPageRoute(builder: (_) => SessionsScreen());
      case '/see-all-screen':
        return NoAnimationMaterialPageRoute(builder: (_) => SeeAllScreen());
      case '/favorite-screen':
        return NoAnimationMaterialPageRoute(builder: (_) => FavoriteScreen());
      case '/detail-screen':
        return MaterialPageRoute(builder: (_) => DetailScreen());
      case '/sessions-subject-screen':
        return NoAnimationMaterialPageRoute(
            builder: (_) => SessionSubjectScreen(
                  title: args,
                ));
      case '/my-tutoring-sessions-screen':
        return MaterialPageRoute(builder: (_) => MyTutoringSessions());
      case '/edit-my-session-screen':
        return MaterialPageRoute(
            builder: (_) => EditMySessionScreen(
                  tutorSession: args,
                ));
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
