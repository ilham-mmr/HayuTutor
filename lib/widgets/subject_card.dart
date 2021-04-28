import 'package:flutter/material.dart';

class SubjectCard extends StatelessWidget {
  final String imagePath;

  const SubjectCard({Key key, this.imagePath}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            imagePath,
          )),
    );
  }
}
