import 'package:flutapp/utils/user_preferences.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  TextEditingController _idController = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _registrationDateController = TextEditingController();

  String picture;

  @override
  void initState() {
    fetchDataFromPreferences();
    super.initState();
  }

  void fetchDataFromPreferences() {
    _idController.text = UserPreferences.getId().toString();
    _emailController.text = UserPreferences.getEmail();
    _fullNameController.text = UserPreferences.getFullName();
    picture = UserPreferences.getPicture();
    _registrationDateController.text = UserPreferences.getRegistrationDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(18),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(picture),
                  radius: 50,
                ),
                Container(
                  margin: EdgeInsets.all(6),
                  padding: EdgeInsets.all(2),
                  child: TextField(
                    textInputAction: TextInputAction.done,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'User ID',
                    ),
                    controller: _idController,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(6),
                  padding: EdgeInsets.all(2),
                  child: TextField(
                    textInputAction: TextInputAction.done,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                    controller: _emailController,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(6),
                  padding: EdgeInsets.all(2),
                  child: TextField(
                    textInputAction: TextInputAction.done,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                    ),
                    controller: _fullNameController,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(6),
                  padding: EdgeInsets.all(2),
                  child: TextField(
                    textInputAction: TextInputAction.done,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Registration Date',
                    ),
                    controller: _registrationDateController,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
