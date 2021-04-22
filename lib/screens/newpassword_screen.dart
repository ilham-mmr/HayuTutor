import 'package:flutapp/mixins/validator.dart';
import 'package:flutapp/models/user.dart';
import 'package:flutapp/screens/signin_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class NewPasswordScreen extends StatefulWidget {
  final otp;
  final email;

  const NewPasswordScreen({Key key, this.otp, this.email}) : super(key: key);
  @override
  _NewPasswordScreenState createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> with Validator {
  final _formKey = GlobalKey<FormState>();
  String _password = '';
  String _confirmPassword = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

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
                    child: SvgPicture.asset("images/forgotpassword.svg"),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 18),
                    child: Row(
                      children: [
                        Text(
                          'Reset Your Password',
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
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: Icon(Icons.lock),
                            labelText: 'New Password',
                            hintText: 'New Password',
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
                        SizedBox(
                          height: 18,
                        ),
                        //check if it's loading
                        _isLoading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : CircleAvatar(
                                backgroundColor: Theme.of(context).primaryColor,
                                child: IconButton(
                                  icon: Icon(Icons.arrow_forward),
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();
                                      if (_password != _confirmPassword) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Mismatch Passwords')));
                                        return;
                                      }
                                      setState(() {
                                        _isLoading = true;
                                      });

                                      bool isSuccess = await Provider.of<User>(
                                              context,
                                              listen: false)
                                          .setPassword(
                                              widget.email,
                                              widget.otp.toString(),
                                              _password.trim());
                                      if (isSuccess) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (content) =>
                                                SigninScreen(),
                                          ),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'Changin Password is success'),
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content:
                                                Text('Changin Password Failed'),
                                          ),
                                        );
                                      }
                                      setState(() {
                                        _isLoading = false;
                                      });
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
