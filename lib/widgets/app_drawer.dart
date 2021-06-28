import 'package:flutapp/utils/user_preferences.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            title: Text('Home'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {},
          ),
          ListTile(
            title: Text('Profile'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pushNamed(context, '/userprofile-screen');
            },
          ),
          ListTile(
            title: Text('My Tutoring Sessions'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              // Navigator.pushNamed(context, '/payment-screen');
            },
          ),
          ListTile(
            title: Text('Log Out'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              UserPreferences.removeEmail();
              UserPreferences.removeFullName();
              UserPreferences.removePicture();
              UserPreferences.removeId();
              UserPreferences.removeRegistrationDate();
              UserPreferences.removeRememberMe();

              Navigator.pushNamedAndRemoveUntil(
                  context, '/landing-screen', (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
