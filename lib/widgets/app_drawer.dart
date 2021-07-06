import 'package:flutapp/utils/user_preferences.dart';
import 'package:flutapp/widgets/user_drawer_header.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          UserDrawerHeader(),
          ListTile(
            title: Text('Home'),
            leading: Icon(Icons.home),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home-screen');
            },
          ),
          ListTile(
            title: Text('Profile'),
            leading: Icon(
              Icons.account_box,
            ),
            onTap: () {
              Navigator.pushNamed(context, '/userprofile-screen');
            },
          ),
          ListTile(
            title: Text('My Tutoring Sessions'),
            leading: Icon(
              Icons.subject_outlined,
            ),
            onTap: () {
              Navigator.pushNamed(context, '/my-tutoring-sessions-screen');
            },
          ),
          ListTile(
            title: Text('Payment History'),
            leading: Icon(
              Icons.payment,
            ),
            onTap: () {
              Navigator.pushNamed(context, '/payment-history-screen');
            },
          ),
          ListTile(
            title: Text('Log Out'),
            leading: Icon(Icons.exit_to_app),
            onTap: () {
              UserPreferences.removeEmail();
              UserPreferences.removeFullName();
              UserPreferences.removePicture();
              UserPreferences.removeId();
              UserPreferences.removeRegistrationDate();
              UserPreferences.removeRememberMe();
              UserPreferences.removeIsTutor();

              Navigator.pushNamedAndRemoveUntil(
                  context, '/landing-screen', (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
