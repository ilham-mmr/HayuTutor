import 'package:flutapp/helpers/noanimation_page_route.dart';
import 'package:flutapp/mixins/validator.dart';
import 'package:flutapp/models/user.dart';
import 'package:flutapp/screens/auth/signin_screen.dart';
import 'package:flutapp/widgets/profile_picture_picker.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> with Validator {
  final _formKey = GlobalKey<FormState>();
  String _fullName = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(18),
              child: Column(
                children: [
                  Container(
                    // child: Image.asset(
                    //   'assets/images/person.png',
                    // ),
                    child: ProfilePicturePicker(),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 18),
                    child: Row(
                      children: [
                        Text(
                          'Sign Up',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
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
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'Full Name',
                            labelStyle: TextStyle(
                              fontSize: 20,
                            ),
                            hintText: 'Full Name',
                            prefixIcon: Icon(Icons.account_box_sharp),
                          ),
                          validator: validateFullName,
                          onSaved: (newValue) => _fullName = newValue,
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        TextFormField(
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
                          ),
                          validator: validatePassword,
                          onSaved: (newValue) => _password = newValue,
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
                            labelText: 'Confirm Password',
                            hintText: 'Confirm Password',
                            labelStyle: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          validator: validatePassword,
                          onSaved: (newValue) => _confirmPassword = newValue,
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Row(
                          children: [
                            Text('Already have an account?'),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  NoAnimationMaterialPageRoute(
                                      builder: (context) => SigninScreen()),
                                );
                              },
                              child: Text(
                                ' Sign In',
                                style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        //check if it's loading or not
                        _isLoading
                            ? CircularProgressIndicator()
                            : CircleAvatar(
                                backgroundColor: Theme.of(context).primaryColor,
                                child: IconButton(
                                  icon: Icon(Icons.arrow_forward),
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      // If the form is valid, display a snackbar. In the real world,
                                      // you'd often call a server or save the information in a database.
                                      _formKey.currentState
                                          .save(); // call onSaved

                                      if (_password == _confirmPassword) {
                                        setState(() {
                                          _isLoading = true;
                                        });
                                        User user = User();
                                        bool isSignedUp = await user.signUp(
                                            _fullName, _email, _password);
                                        if (isSignedUp) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Registered Successfully. Check your email to verify'),
                                            ),
                                          );
                                          setState(() {
                                            _isLoading = false;
                                          });
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SigninScreen(),
                                            ),
                                          );
                                        } else {
                                          setState(() {
                                            _isLoading = false;
                                          });
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      'Registration failed: invalid input/email is already taken')));
                                        }
                                      } else {
                                        setState(() {
                                          _isLoading = false;
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Mismatch Passwords')));
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
            ),
          ),
        ),
      ),
    );
  }
}
