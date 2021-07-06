import 'package:flutapp/models/tutors.dart';
import 'package:flutapp/widgets/tutor_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorited Tutors'),
      ),
      body: Container(
        child: Consumer<FavoriteTutorListProvider>(
          builder: (context, tutor, _) {
            var data = tutor.favoriteList;
            return ListView(
              children: data.length != 0
                  ? data
                      .map<Widget>((e) => Dismissible(
                            background: Container(color: Colors.red[900]),
                            key: Key(e.tutorId.toString()),
                            onDismissed: (direction) {
                              tutor.deleteFromFavoriteList(e.tutorId);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      duration: Duration(milliseconds: 500),
                                      content:
                                          Text('${e.fullName} dismissed')));
                            },
                            child: TutorCard(
                              tutor: e,
                              showButton: false,
                            ),
                          ))
                      .toList()
                  : [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: SvgPicture.asset(
                              "assets/images/add_tutor.svg",
                              height: height * 0.5,
                            ),
                          ),
                          Center(
                            child: Text(
                              'Start Adding Tutors now',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20),
                            ),
                          ),
                        ],
                      )
                    ],
            );
          },
        ),
      ),
    );
  }
}
