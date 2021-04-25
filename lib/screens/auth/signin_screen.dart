import 'package:flutapp/helpers/noanimation_page_route.dart';
import 'package:flutapp/models/user.dart';
import 'package:flutapp/screens/auth/forgot_validation_screen.dart';
import 'package:flutapp/screens/auth/signup_screen.dart';
import 'package:flutapp/screens/auth/home_screen.dart';
import 'package:flutapp/utils/user_preferences.dart';
import 'package:flutapp/mixins/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SigninScreen extends StatefulWidget {
  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> with Validator {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  bool _isLoading = false;

  @override
  void initState() {
    _email = UserPreferences.getEmail() ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(6),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(18),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: height * 0.28,
                            child: Image.asset(
                              'assets/images/logo.png',
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 18),
                            child: Row(
                              children: [
                                Text(
                                  'Login',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  initialValue: _email,
                                  onChanged: (value) {
                                    _email = value;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    labelText: 'Email Address',
                                    labelStyle: TextStyle(
                                      fontSize: 20,
                                    ),
                                    hintText: 'youremail@example.com',
                                    prefixIcon: Icon(Icons.email),
                                  ),
                                  validator: validateEmail,
                                  onSaved: (newValue) => _email = newValue,
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                TextFormField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      prefixIcon: Icon(Icons.lock),
                                      labelText: 'Password',
                                      hintText: 'Password',
                                      labelStyle: TextStyle(
                                        fontSize: 20,
                                      ),
                                      suffixIcon: Padding(
                                          padding: EdgeInsets.all(15),
                                          child: GestureDetector(
                                            onTap: _forgotPassword,
                                            child: Text(
                                              'forgot?',
                                              style:
                                                  _boldCyanTextStyle(context),
                                            ),
                                          ))),
                                  validator: validatePassword,
                                  onSaved: (newValue) => _password = newValue,
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                Row(
                                  children: [
                                    Text('New to this app?'),
                                    GestureDetector(
                                      onTap: () async {
                                        await UserPreferences.setEmail(_email);
                                        Navigator.pushReplacement(
                                          context,
                                          NoAnimationMaterialPageRoute(
                                              builder: (context) =>
                                                  SignupScreen()),
                                        );
                                      },
                                      child: Text(
                                        ' Sign Up',
                                        style: _boldCyanTextStyle(context),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                //check if it's loading
                                _isLoading
                                    ? Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : CircleAvatar(
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                        child: IconButton(
                                          icon: Icon(Icons.arrow_forward),
                                          onPressed: () async {
                                            // Validate returns true if the form is valid, or false otherwise.
                                            if (_formKey.currentState
                                                .validate()) {
                                              // If the form is valid, display a snackbar. In the real world,
                                              // you'd often call a server or save the information in a database.
                                              _formKey.currentState
                                                  .save(); // call onSaved

                                              setState(() {
                                                _isLoading = true;
                                              });
                                              bool isSignedIn =
                                                  await Provider.of<User>(
                                                          context,
                                                          listen: false)
                                                      .signIn(
                                                          _email, _password);

                                              // bool isSignedIn =
                                              //     await user.signIn(_email, _password);

                                              setState(() {
                                                _isLoading = false;
                                              });

                                              if (isSignedIn) {
                                                Navigator.pushReplacement(
                                                  context,
                                                  NoAnimationMaterialPageRoute(
                                                    builder: (context) =>
                                                        HomeScreen(),
                                                  ),
                                                );
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                        'invalid email/password'),
                                                  ),
                                                );
                                              }
                                            }
                                          },
                                        ),
                                      ),
                              ],
                            ),
                          )
                        ],
                      ),
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

  TextStyle _boldCyanTextStyle(BuildContext context) {
    return TextStyle(
        color: Theme.of(context).accentColor, fontWeight: FontWeight.bold);
  }

  void sendForgotEmail(String email) async {
    if (!email.contains('@')) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('invalid email')));
      return;
    }
    setState(() {
      _isLoading = true;
    });

    var response =
        await Provider.of<User>(context, listen: false).forgotPassword(email);
    if (response) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (content) => ForgotValidationScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Oops try to resend it again!')));
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _forgotPassword() {
    TextEditingController _forgotFieldController = TextEditingController();
    String info = '';
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Enter your recovey email'),
        content: Container(
            height: 100,
            child: Column(
              children: [
                TextField(
                  controller: _forgotFieldController,
                  decoration: InputDecoration(
                      labelText: 'Email', icon: Icon(Icons.email)),
                ),
                Text('$info')
              ],
            )),
        actions: [
          TextButton(
            child: Text(
              "Submit",
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            onPressed: () async {
              String email = _forgotFieldController.text;
              sendForgotEmail(email);
              Navigator.of(context).pop();
            },
          ),
          TextButton(
              child: Text(
                "Cancel",
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ],
      ),
    );
  }
}
