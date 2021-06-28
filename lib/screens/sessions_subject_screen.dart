import 'package:flutapp/models/tutor_session.dart';
import 'package:flutapp/widgets/session_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SessionSubjectScreen extends StatelessWidget {
  final String title;
  const SessionSubjectScreen({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${title.substring(0, 1).toUpperCase()}${title.substring(1)} Tutoring Session'),
      ),
      body: Consumer<TutorSessionProvider>(
        builder: (context, tutor, _) => FutureBuilder(
          future: tutor.getSessionsBySubject(title),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            var data = snapshot.data;
            print('hihi');
            return data.length == 0
                ? Center(
                    child: Text(
                      'coming soon',
                      style: TextStyle(fontSize: 30),
                    ),
                  )
                : ListView(
                    children: data
                        .map<Widget>((session) => SessionCard(
                              tutorSession: session,
                              clickAblePicture: true,
                            ))
                        .toList(),
                  );
          },
        ),
      ),
    );
  }
}
