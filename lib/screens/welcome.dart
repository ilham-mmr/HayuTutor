import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            color: Colors.black,
            height: 100,
            width: 100,
            child: Text("welcome"),
          ),
        ),
      ),
    );
  }
}
