import 'package:flutapp/models/user.dart';
import 'package:flutapp/screens/search_tutor_screen.dart';
import 'package:flutapp/widgets/app_drawer.dart';
import 'package:flutapp/widgets/bottom_nav_FAB.dart';
import 'package:flutapp/widgets/subject_card.dart';
import 'package:flutapp/widgets/tutor_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final bottomNavFAB;

  const HomeScreen({Key key, this.bottomNavFAB}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).accentColor,
          // leading: Container(),
          elevation: 0,
          actions: [
            IconButton(icon: Icon(Icons.favorite), onPressed: () {}),
          ],
        ),
        drawer: AppDrawer(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 125,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                    color: Theme.of(context).accentColor,
                  ),
                  child: Row(children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Hello, ',
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w500),
                            ),
                            Consumer<User>(
                              builder: (BuildContext context, user, _) {
                                return Container(
                                  child: Column(
                                    children: [
                                      Text(
                                        "${user.fullname.split(' ')[0]}",
                                        style: TextStyle(
                                            fontSize: 30,
                                            color: Colors.white70,
                                            fontWeight: FontWeight.w500),
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Consumer<User>(
                        builder: (BuildContext context, user, _) =>
                            CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                              'https://luxfortis.studio/app/images/profile_pictures/${user.picture}'),
                        ),
                      ),
                    ),
                  ]),
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (content) => SearchTutorScreen()));
                        },
                        child: TextFormField(
                          enabled: false,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelStyle: TextStyle(
                              fontSize: 20,
                            ),
                            hintText: 'Search Tutor here',
                            prefixIcon: Icon(Icons.search),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Subjects',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        height: 120,
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: [
                            SubjectCard(
                              imagePath: 'assets/images/biology.png',
                            ),
                            SubjectCard(
                              imagePath: 'assets/images/english.png',
                            ),
                            SubjectCard(
                              imagePath: 'assets/images/history.png',
                            ),
                            SubjectCard(
                              imagePath: 'assets/images/maths.png',
                            ),
                            SubjectCard(
                              imagePath: 'assets/images/physics.png',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Tutors',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      TutorCard(),
                      TutorCard(),
                      TutorCard(),
                      TutorCard(),
                      TutorCard(),
                      TutorCard(),
                      TutorCard(),

                      // Container(
                      //   height: 350,
                      //   child: ListView(
                      //     children: [
                      //       TutorCard(),
                      //       TutorCard(),
                      //       TutorCard(),
                      //       TutorCard(),
                      //       TutorCard()
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: BottomNavFAB(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
