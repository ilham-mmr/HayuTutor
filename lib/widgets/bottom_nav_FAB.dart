import 'package:flutapp/screens/add_session_screen.dart';
import 'package:flutapp/screens/sessions_screen.dart';
import 'package:flutter/material.dart';

class BottomNavFAB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 70,
        width: MediaQuery.of(context).size.width - (2 + 18),
        padding: EdgeInsets.all(0),
        margin: EdgeInsets.symmetric(horizontal: 18),
        decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.circular(30)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: _customIconButton(
                  iconData: Icons.favorite, label: 'Favorite', onTap: () {}),
            ),
            Expanded(
              child: _customIconButton(
                  iconData: Icons.add_box_rounded,
                  label: 'Add',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (content) => AddSessionScreen()));
                  }),
            ),
            Expanded(
              child: _customIconButton(
                  iconData: Icons.school,
                  label: 'Sessions',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (content) => SessionsScreen()));
                  }),
            ),
          ],
        ));
  }

  GestureDetector _customIconButton(
      {Function onTap, IconData iconData, String label}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            color: Colors.white,
          ),
          Text(
            label,
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
