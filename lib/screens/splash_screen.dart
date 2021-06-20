import 'dart:async';
import 'package:flutapp/utils/user_preferences.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _rememberMe = false;
  @override
  void initState() {
    super.initState();
    _rememberMe = UserPreferences.getRememberMe() ?? false;
    Timer(
        Duration(seconds: 2),
        () => Navigator.of(context).pushReplacementNamed(
            _rememberMe ? '/home-screen' : '/landing-screen'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                margin: EdgeInsets.all(50),
                child: Image.asset('assets/images/logo.png'))
          ],
        ),
      ),
    );
  }
}
