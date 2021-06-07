import 'package:flutapp/helpers/route_generator.dart';
import 'package:flutapp/models/image_cus_provider.dart';
import 'package:flutapp/models/subjects.dart';
import 'package:flutapp/models/tutor_session.dart';
import 'package:flutapp/models/tutors.dart';
import 'package:flutapp/models/user.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => User(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => ImageCusProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => SubjectProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => TutorProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => TutorSessionProvider(),
        ),
      ],
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
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
