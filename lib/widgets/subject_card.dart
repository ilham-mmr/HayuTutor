import 'package:flutapp/models/subjects.dart';
import 'package:flutter/material.dart';

class SubjectCard extends StatelessWidget {
  final Subject subject;

  const SubjectCard({Key key, this.subject}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            subject.image,
          )),
    );
  }
}
