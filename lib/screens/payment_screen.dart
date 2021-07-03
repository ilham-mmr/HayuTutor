import 'dart:async';

import 'package:flutapp/models/tutor_session.dart';
import 'package:flutapp/utils/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentScreen extends StatefulWidget {
  final TutorSession tutorSession;

  const PaymentScreen({Key key, this.tutorSession}) : super(key: key);
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    String email = UserPreferences.getEmail();
    String fullName = UserPreferences.getFullName();
    double amount = widget.tutorSession.price;
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: WebView(
                  initialUrl:
                      'https://luxfortis.studio/app/payment/generate_bill.php?email=' +
                          "$email" +
                          '&name=' +
                          "$fullName" +
                          '&amount=' +
                          "$amount" +
                          '&mobile=' +
                          "+60122345678",
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller.complete(webViewController);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
