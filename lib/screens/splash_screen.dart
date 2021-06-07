import 'dart:async';
import 'package:flutapp/utils/user_preferences.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _userEmail;
  @override
  void initState() {
    super.initState();
    _userEmail = UserPreferences.getEmail();
    Timer(
        Duration(seconds: 2),
        () => Navigator.of(context).pushReplacementNamed(
            _userEmail != null ? '/home-screen' : '/landing-screen'));
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
