import 'package:flutapp/models/subjects.dart';
import 'package:flutapp/models/tutors.dart';
import 'package:flutapp/models/user.dart';
import 'package:flutapp/screens/search_tutor_screen.dart';
import 'package:flutapp/utils/user_preferences.dart';
import 'package:flutapp/widgets/app_drawer.dart';
import 'package:flutapp/widgets/bottom_nav_FAB.dart';
import 'package:flutapp/widgets/subject_card.dart';
import 'package:flutapp/widgets/tutor_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String email;
  String fullName;
  String picture;
  @override
  void initState() {
    super.initState();
    email = UserPreferences.getEmail();
    fullName = UserPreferences.getFullName();
    picture = UserPreferences.getPicture();
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context, listen: false);
    if (user.email == null && user.fullName == null) {
      user.email = email;
      user.fullName = fullName;
      user.picture = picture;
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        drawer: AppDrawer(),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 185,
                backgroundColor: Colors.white70,
                flexibleSpace: FlexibleSpaceBar(
                  background: _buildNameAndProfileContainer(context),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
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
                                      builder: (content) =>
                                          SearchTutorScreen()));
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
                            child: Consumer<SubjectProvider>(
                              builder: (context, subject, _) => FutureBuilder(
                                  future: subject.getSubjects(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      var data = snapshot.data;
                                      return ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: data
                                            .map<Widget>(
                                                (subjectItem) => SubjectCard(
                                                      subject: subjectItem,
                                                    ))
                                            .toList(),
                                      );
                                    }
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Tutors',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  IconButton(
                                      icon: Icon(Icons.refresh),
                                      onPressed: () {
                                        setState(() {});
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text('Refreshed'),
                                          ),
                                        );
                                      })
                                ],
                              ),
                              Text(
                                'See All',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          Consumer<TutorProvider>(
                            builder: (context, tutor, _) => FutureBuilder(
                              future: tutor.getCardTutors(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  var data = snapshot.data;
                                  print('hihi');
                                  data.map((item) => print(item.fullName));
                                  return Column(
                                    children: data
                                        .map<Widget>((tutorItem) => TutorCard(
                                              tutor: tutorItem,
                                            ))
                                        .toList(),
                                  );
                                }
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 80,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        floatingActionButton: BottomNavFAB(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Container _buildNameAndProfileContainer(BuildContext context) {
    return Container(
      height: 125,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
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
                            "${user.fullName.split(' ')[0]}",
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
            builder: (BuildContext context, user, _) => CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user.picture),
            ),
          ),
        ),
      ]),
    );
  }
}
