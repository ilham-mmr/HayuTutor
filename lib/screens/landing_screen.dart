import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SvgPicture.asset(
              "assets/images/appreciation.svg",
              height: height * 0.35,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: height * 0.28,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Text(
                    'Find your best tutors here',
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Text(
                    'The cure for boredom is curiosity. There is no cure for curiosity',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).accentColor, // background
                      onPrimary: Colors.white, // foreground
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/signin-screen');
                    },
                    child: Text('Explore Now'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
