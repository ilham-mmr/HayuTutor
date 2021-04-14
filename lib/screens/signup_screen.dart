import 'package:flutapp/screens/signin_screen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
                    height: 200,
                    child: Image.asset(
                      'images/logo.png',
                    ),
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
                          validator: _validateFullName,
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
                          validator: _validateEmail,
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
                          validator: _validatePassword,
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
                          validator: _validatePassword,
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
                                  MaterialPageRoute(
                                      builder: (context) => SigninScreen()),
                                );
                              },
                              child: Text(
                                ' Sign In',
                                style: TextStyle(color: Colors.blue),
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
                                        var url = Uri.parse(
                                            'https://luxfortis.studio/app/register_user.php');
                                        var response =
                                            await http.post(url, body: {
                                          'full_name': _fullName.trim(),
                                          'email': _email.trim(),
                                          'password': _password.trim()
                                        });
                                        if (response.body == 'success') {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      'Registered Successfully. Check your email to verify')));
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

  String _validateEmail(String value) {
    if (!value.contains('@')) {
      return 'Please enter a valid email';
    }

    return null;
  }

  String _validatePassword(String value) {
    if (value.length < 4) {
      return 'Password must be more than 4 characters';
    }
    return null;
  }

  String _validateFullName(String value) {
    if (value.isEmpty || value == '') {
      return 'Full Name must not be empty';
    }
    return null;
  }
}
