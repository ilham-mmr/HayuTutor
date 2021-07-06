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
    int id = UserPreferences.getId();
    String email = UserPreferences.getEmail();
    String fullName = UserPreferences.getFullName();
    double amount = widget.tutorSession.price;
    return Scaffold(
        appBar: AppBar(
          title: Text('Payment'),
        ),
        body: Center(
            child: id != widget.tutorSession.tutorId
                ? Container(
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
                                    '&sessionId=' +
                                    "${widget.tutorSession.sessionId}" +
                                    "&userId=" +
                                    "$id",
                            javascriptMode: JavascriptMode.unrestricted,
                            onWebViewCreated:
                                (WebViewController webViewController) {
                              _controller.complete(webViewController);
                            },
                          ),
                        )
                      ],
                    ),
                  )
                : Text(
                    'You are not allowed to book yourself',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 28),
                  )));
  }
}
