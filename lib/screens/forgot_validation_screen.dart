import 'package:flutapp/models/user.dart';
import 'package:flutapp/screens/newpassword_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class ForgotValidationScreen extends StatefulWidget {
  @override
  _ForgotValidationScreenState createState() => _ForgotValidationScreenState();
}

class _ForgotValidationScreenState extends State<ForgotValidationScreen> {
  TextEditingController _controller = new TextEditingController();

  int attempt = 1;
  String email = '';
  String forgotOtp = '';
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context, listen: true);
    email = user.forgotEmail;
    forgotOtp = user.forgotOtp;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  'Verification Code',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                SvgPicture.asset(
                  "images/mypassword.svg",
                  height: 200,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Please type the code sent to $email',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                Container(
                  margin: EdgeInsets.all(16),
                  padding: EdgeInsets.all(18),
                  child: PinCodeTextField(
                    keyboardType: TextInputType.number,
                    length: 4,
                    obscureText: false,
                    animationType: AnimationType.scale,
                    controller: _controller,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                    ),
                    animationDuration: Duration(milliseconds: 300),
                    onCompleted: (value) {
                      if (value == forgotOtp) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewPasswordScreen(
                                    email: email,
                                    otp: forgotOtp,
                                  )),
                        );
                      }
                      if (attempt == 3) {
                        setState(() {});
                      }
                      attempt++;

                      _controller.clear();
                    },
                    appContext: context,
                    onChanged: (value) {},
                    enabled: true,
                  ),
                ),
                attempt > 2
                    ? TextButton(
                        onPressed: _resendCode,
                        child: Text(
                          'Resend The Code',
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    : Text('')
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _resendCode() async {
    setState(() {
      attempt = 1;
    });
    var response =
        await Provider.of<User>(context, listen: false).forgotPassword(email);
    if (response) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Successfully resent the code to ${email}')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Oops there is an error')));
    }
  }
}
