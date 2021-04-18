import 'package:flutapp/models/user.dart';
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
        title: 'Flutter Demo',
        theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
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
      ),
    );
  }
}
