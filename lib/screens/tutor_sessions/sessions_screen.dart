import 'package:flutapp/models/tutor_session.dart';
import 'package:flutapp/widgets/session_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SessionsScreen extends StatefulWidget {
  @override
  _SessionsScreenState createState() => _SessionsScreenState();
}

class _SessionsScreenState extends State<SessionsScreen> {
  final TextEditingController textEditingController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Tutoring Session'),
        backgroundColor: Theme.of(context).accentColor,
        // leading: Container(),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.all(18),
              padding: EdgeInsets.all(6),
              child: TextField(
                textInputAction: TextInputAction.done,
                onSubmitted: (value) {
                  _querySearch(context, value);
                },
                decoration: InputDecoration(
                  hintText: 'e.g Biology / alex',
                  suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        _querySearch(context, textEditingController.text);
                      }),
                ),
                controller: textEditingController,
              ),
            ),
            Expanded(
              flex: 10,
              child: Consumer<TutorSessionProvider>(
                builder: (context, tutorSession, _) {
                  List<TutorSession> sessionList =
                      tutorSession.tutorSessionList;
                  return sessionList.isNotEmpty
                      ? isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : ListView.builder(
                              itemCount: sessionList.length,
                              itemBuilder: (context, index) {
                                return SessionCard(
                                  tutorSession: sessionList[index],
                                );
                              },
                            )
                      : Center(
                          child: Text('No data. Search Now!'),
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _querySearch(BuildContext context, String keyword) async {
    if (keyword.isEmpty || keyword == '') {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please no empty keyword ')));
      return;
    }
    setState(() {
      isLoading = true;
    });
    bool isFound =
        await Provider.of<TutorSessionProvider>(context, listen: false)
            .searchSessionByKeyword(keyword);
    setState(() {
      isLoading = false;
    });
    if (!isFound) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Not Found')));
      return;
    }
  }
}
