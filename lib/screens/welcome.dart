import 'package:flutapp/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            child: Consumer<User>(
              builder: (BuildContext context, user, _) {
                return Text(
                    "${user.fullname} and ${user.email} and ${user.registrationDate}");
              },
            ),
          ),
        ),
      ),
    );
  }
}
