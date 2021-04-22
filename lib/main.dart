import 'package:flutapp/models/user.dart';
import 'package:flutapp/screens/landing_screen.dart';
import 'package:flutapp/screens/splash_screen.dart';
import 'package:flutapp/utils/user_preferences.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<User>(
      create: (BuildContext context) => User(),
      child: MaterialApp(
        title: 'HayuTutor',
        theme: ThemeData(
            primaryColor: Color(0xFF1D4E56),
            accentColor: Colors.cyan[800],
            textSelectionTheme: TextSelectionThemeData(
                cursorColor: Color(0xFF1D4E56),
                selectionHandleColor: Color(0xFF1D4E56),
                selectionColor: Colors.cyan[800]),
            backgroundColor: Color(0xFF1D4E56),
            buttonTheme: ButtonThemeData(
              buttonColor: Color(0xFF9AD3C6),
            ),

            // accentColorBrightness: ,
            textTheme: GoogleFonts.ralewayTextTheme()),
        home: SplashScreen(),
        routes: {},
      ),
    );
  }
}
