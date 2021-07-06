import 'package:flutapp/models/tutor_session.dart';
import 'package:flutapp/screens/tutor_sessions/detail_screen.dart';
import 'package:flutter/material.dart';

class SessionCard extends StatelessWidget {
  final TutorSession tutorSession;
  final bool clickAblePicture;
  const SessionCard({key, this.tutorSession, this.clickAblePicture = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${tutorSession.subject}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.timelapse),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      '${tutorSession.duration} mins',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_city),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      '${tutorSession.location}',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.date_range),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      'on ${tutorSession.date}',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.timer),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      'at ${tutorSession.time}',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'RM',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      '${tutorSession.price}',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: clickAblePicture
                      ? () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (content) => DetailScreen(
                                        fullName: tutorSession.fullName,
                                        id: tutorSession.tutorId,
                                        picture: tutorSession.picture,
                                      )));
                        }
                      : () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(tutorSession.picture),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  '${tutorSession.fullName}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Book ->'),
                    IconButton(
                      color: Theme.of(context).accentColor,
                      icon: Icon(Icons.book),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/payment-screen',
                            arguments: tutorSession);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
