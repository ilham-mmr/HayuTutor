import 'package:flutapp/models/user.dart';
import 'package:flutapp/utils/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({key}) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  int id;
  String email, fullName, picture, registrationDate;
  bool rememberMe;

  User user;
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _fullNameController = new TextEditingController();

  var refreshKey = GlobalKey<RefreshIndicatorState>();

  bool _readOnlyFullName = true;
  bool _isTutor = false;
  @override
  void initState() {
    super.initState();

    rememberMe = UserPreferences.getRememberMe() ?? false;
    if (rememberMe) {
      // fetchDataFromPreferences();
      return;
    }

    //fetch from providers.
    user = Provider.of<User>(context, listen: false);

    // id = user.id;
    // email = user.userEmail;
    // fullName = user.fullName;
    // picture = user.picture;
    // registrationDate = user.registrationDate;
    // _isTutor = user.isTutor;
  }

  // void fetchDataFromPreferences() {
  //   id = UserPreferences.getId();
  //   email = UserPreferences.getEmail();
  //   fullName = UserPreferences.getFullName();
  //   picture = UserPreferences.getPicture();
  //   registrationDate = UserPreferences.getRegistrationDate();
  // }

  @override
  Widget build(BuildContext context) {
    _emailController.text = email;
    _fullNameController.text = fullName;
    // user = Provider.of<User>(context, listen: true);

    // id = user.id;
    // email = user.userEmail;
    // fullName = user.fullName;
    // picture = user.picture;
    // registrationDate = user.registrationDate;
    // _isTutor = user.isTutor;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            tooltip: 'Save Profile Setting',
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(18),
            child: Column(
              children: [
                // ProfilePicturePicker(picture),
                Container(
                  margin: EdgeInsets.all(18),
                  padding: EdgeInsets.all(6),
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
                  margin: EdgeInsets.all(18),
                  padding: EdgeInsets.all(6),
                  child: TextField(
                    textInputAction: TextInputAction.done,
                    readOnly: _readOnlyFullName,
                    onChanged: (value) => fullName = value,
                    decoration: InputDecoration(
                      hintText: fullName,
                      labelText: 'Full Name',
                      suffixIcon: IconButton(
                          icon: !_readOnlyFullName
                              ? Icon(Icons.check)
                              : Icon(Icons.edit),
                          onPressed: () {
                            setState(() {
                              _readOnlyFullName = !_readOnlyFullName;
                            });
                          }),
                    ),
                    controller: _fullNameController,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(18),
                  padding: EdgeInsets.all(6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tutor'),
                      Switch(value: _isTutor, onChanged: (value) {}),
                    ],
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
