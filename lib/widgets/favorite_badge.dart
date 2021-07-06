import 'package:badges/badges.dart';
import 'package:flutapp/models/tutors.dart';
import 'package:flutapp/screens/user/favorite_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (content) => FavoriteScreen()));
      },
      child: Container(
        margin: EdgeInsets.all(18),
        child: Consumer<FavoriteTutorListProvider>(
            builder: (context, favoriteList, _) {
          int length = favoriteList.favoriteList.length;
          return Badge(
            showBadge: length == 0 ? false : true,
            badgeColor: Theme.of(context).accentColor,
            badgeContent: Text('$length',
                style: TextStyle(
                  color: Colors.white,
                )),
            child: Icon(Icons.add),
          );
        }),
      ),
    );
  }
}
