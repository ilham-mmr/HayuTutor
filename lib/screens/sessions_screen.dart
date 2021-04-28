import 'package:flutapp/widgets/bottom_nav_FAB.dart';
import 'package:flutter/material.dart';

class SessionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        // leading: Container(),
        elevation: 0,
        actions: [
          IconButton(icon: Icon(Icons.favorite), onPressed: () {}),
        ],
      ),
      body: Container(
        child: Center(
          child: Card(
            child: Text('sessions'),
          ),
        ),
      ),
    );
  }
}
