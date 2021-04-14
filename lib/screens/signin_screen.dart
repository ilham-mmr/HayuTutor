import 'package:flutapp/screens/signup_screen.dart';
import 'package:flutapp/screens/welcome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SigninScreen extends StatefulWidget {
  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
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
                          'Login',
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
                              suffixIcon: Padding(
                                  padding: EdgeInsets.all(15),
                                  child: GestureDetector(
                                    onTap: _forgotPassword,
                                    child: Text(
                                      'forgot?',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ))),
                          validator: _validatePassword,
                          onSaved: (newValue) => _password = newValue,
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Row(
                          children: [
                            Text('New to this app?'),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignupScreen()),
                                );
                              },
                              child: Text(
                                ' Sign Up',
                                style: TextStyle(color: Colors.blue),
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
                                child: IconButton(
                                  icon: Icon(Icons.arrow_forward),
                                  onPressed: () async {
                                    // Validate returns true if the form is valid, or false otherwise.
                                    if (_formKey.currentState.validate()) {
                                      // If the form is valid, display a snackbar. In the real world,
                                      // you'd often call a server or save the information in a database.
                                      _formKey.currentState
                                          .save(); // call onSaved

                                      setState(() {
                                        _isLoading = true;
                                      });
                                      var url = Uri.parse(
                                          'https://luxfortis.studio/app/login_user.php');
                                      var response = await http.post(url,
                                          body: {
                                            'email': _email.trim(),
                                            'password': _password.trim()
                                          });
                                      setState(() {
                                        _isLoading = false;
                                      });

                                      if (response.body == 'success') {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Welcome(),
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    'invalid email/password')));
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

  void _forgotPassword() {
    TextEditingController _forgotFieldController = TextEditingController();
    showDialog(
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
                )
              ],
            )),
        actions: [
          TextButton(
            child: Text("Submit"),
            onPressed: () {
              if (_forgotFieldController.text.toString().contains('@')) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('sending to server')));
              } else {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('invalid email')));
              }
            },
          ),
          TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ],
      ),
    );
  }
}
