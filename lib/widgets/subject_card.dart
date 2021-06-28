import 'package:flutapp/models/subjects.dart';
import 'package:flutter/material.dart';

class SubjectCard extends StatelessWidget {
  final bool tappable;
  final Subject subject;

  const SubjectCard({Key key, this.subject, this.tappable = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tappable
          ? () {
              Navigator.of(context).pushNamed('/sessions-subject-screen',
                  arguments: subject.title);
            }
          : () {},
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            subject.image,
          ),
        ),
      ),
    );
  }
}
