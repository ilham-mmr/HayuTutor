import 'package:flutapp/models/subjects.dart';
import 'package:flutapp/models/tutor_session.dart';
import 'package:flutapp/widgets/session_card.dart';
import 'package:flutapp/widgets/subject_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatelessWidget {
  final int id;
  final String fullName;
  final String picture;
  const DetailScreen({Key key, this.id, this.fullName, this.picture})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewPadding.top;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Image.network(
              picture,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            ListView(
              children: [
                SizedBox(
                  height: height * 0.4,
                ),
                Container(
                  width: width,
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(18)),
                      color: Colors.white),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: Text(
                          fullName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 30),
                        ),
                      ),
                      Consumer<TutorSessionProvider>(
                        builder: (context, session, _) => FutureBuilder(
                            future: session.getSessionById('$id'),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var data = snapshot.data;

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        'Subjects Taught by ${fullName.split(' ')[0]}',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Container(
                                        height: 150,
                                        child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          children: data
                                              .map<Widget>(
                                                (e) => Container(
                                                  height: 150,
                                                  width: 150,
                                                  child: SubjectCard(
                                                    subject: Subject(
                                                        image:
                                                            'https://luxfortis.studio/app/images/subjects/${e.subject.toLowerCase()}.png'),
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        'Tutoring Sessions by ${fullName.split(' ')[0]}',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Column(
                                      children: data
                                          .map<Widget>((e) => SessionCard(
                                                tutorSession: e,
                                              ))
                                          .toList(),
                                    ),
                                  ],
                                );
                              }
                              return Container(
                                height: height * 30,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                )
              ],
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  child: Icon(Icons.arrow_back),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
