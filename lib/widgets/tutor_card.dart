import 'package:flutapp/models/tutors.dart';
import 'package:flutapp/screens/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TutorCard extends StatelessWidget {
  final Tutor tutor;
  final bool showButton;
  const TutorCard({this.tutor, this.showButton});
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  '${tutor.fullName}',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  tutor.subject,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  tutor.location,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (content) => DetailScreen(
                                  fullName: tutor.fullName,
                                  id: tutor.tutorId,
                                  picture: tutor.picture,
                                )));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(tutor.picture),
                    ),
                  ),
                ),
                showButton
                    ? IconButton(
                        color: Theme.of(context).accentColor,
                        icon: Icon(Icons.add_box),
                        onPressed: () {
                          bool isAdded = Provider.of<FavoriteTutorListProvider>(
                                  context,
                                  listen: false)
                              .addToFavoriteList(tutor);
                          if (isAdded) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                duration: const Duration(seconds: 1),
                                content: Text('${tutor.fullName} added')));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                duration: const Duration(seconds: 1),
                                content: Text(
                                  '${tutor.fullName} was already added',
                                )));
                          }
                        },
                      )
                    : Container()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
