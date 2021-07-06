import 'package:flutapp/models/user.dart';
import 'package:flutapp/utils/user_preferences.dart';
import 'package:flutapp/widgets/payment_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentHistoryScreen extends StatelessWidget {
  const PaymentHistoryScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment History'),
      ),
      body: SafeArea(
        child: Consumer<User>(
          builder: (context, user, _) => FutureBuilder(
            future: user.getPaymentHistory(UserPreferences.getEmail()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              var data = snapshot.data;

              return data.length == 0
                  ? Center(
                      child: Text(
                        'Book Tutors Now',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    )
                  : ListView(
                      children: data
                          .map<Widget>(
                            (payment) => PaymentCard(
                              payment: payment,
                            ),
                          )
                          .toList(),
                    );
            },
          ),
        ),
      ),
    );
  }
}
