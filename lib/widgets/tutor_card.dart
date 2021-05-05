import 'package:flutapp/models/tutors.dart';
import 'package:flutter/material.dart';

class TutorCard extends StatelessWidget {
  final Tutor tutor;

  const TutorCard({Key key, this.tutor}) : super(key: key);

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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${tutor.price}RM/hour',
                    style: TextStyle(
                      fontSize: 16,
                    ),
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(tutor.picture),
                    ),
                  ),
                  IconButton(
                    color: Theme.of(context).accentColor,
                    icon: Icon(Icons.favorite),
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
