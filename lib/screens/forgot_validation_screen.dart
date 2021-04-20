import 'package:flutapp/screens/newpassword_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ForgotValidationScreen extends StatefulWidget {
  final otp;
  final email;

  const ForgotValidationScreen({Key key, this.otp, this.email})
      : super(key: key);
  @override
  _ForgotValidationScreenState createState() => _ForgotValidationScreenState();
}

class _ForgotValidationScreenState extends State<ForgotValidationScreen> {
  TextEditingController _controller = new TextEditingController();

  int attempt = 1;

  @override
  Widget build(BuildContext context) {
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
                  'Please type the code sent to ${widget.email}',
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
                      if (value == widget.otp.toString()) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewPasswordScreen(
                                    email: widget.email,
                                    otp: widget.otp,
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

  void _resendCode() {
    setState(() {
      attempt = 1;
    });
  }
}
