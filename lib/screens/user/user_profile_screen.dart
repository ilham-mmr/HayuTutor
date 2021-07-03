import 'package:flutapp/models/image_cus_provider.dart';
import 'package:flutapp/models/user.dart';
import 'package:flutapp/utils/user_preferences.dart';
import 'package:flutapp/widgets/profile_picture_picker.dart';
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
    fetchDataFromPreferences();

    super.initState();
  }

  void fetchDataFromPreferences() {
    id = UserPreferences.getId();
    email = UserPreferences.getEmail();
    fullName = UserPreferences.getFullName();
    picture = UserPreferences.getPicture();
    registrationDate = UserPreferences.getRegistrationDate();

    _emailController.text = email;
    _fullNameController.text = fullName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            tooltip: 'Save Profile Setting',
            onPressed: () {
              _onSave();
            },
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
                ProfilePicturePicker(picture),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onSave() async {
    String encodedBase64string =
        Provider.of<ImageCusProvider>(context, listen: false).base64Image;
    print(encodedBase64string);
    print(fullName);
    var user = Provider.of<User>(context, listen: false);
    bool isSaved = await user.updateProfile(id, fullName, encodedBase64string);

    UserPreferences.removeFullName();
    UserPreferences.removePicture();
    await UserPreferences.setFullName(user.fullName);
    await UserPreferences.setPicture(user.picture);
    if (isSaved) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Successfully updated the profile')));
      return;
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Failed to update the profile')));
  }
}
