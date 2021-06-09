import 'package:flutapp/models/tutor_session.dart';
import 'package:flutter/material.dart';

class SessionCard extends StatelessWidget {
  final TutorSession tutorSession;
  const SessionCard({key, this.tutorSession}) : super(key: key);

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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  '${tutorSession.duration}',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  '${tutorSession.location}',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                Text(
                  'on ${tutorSession.date}',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                Text(
                  'at ${tutorSession.time}',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                Text(
                  'RM${tutorSession.price}',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(tutorSession.picture),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text('${tutorSession.fullName}'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Book ->'),
                    IconButton(
                      color: Theme.of(context).accentColor,
                      icon: Icon(Icons.book),
                      onPressed: () {},
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
