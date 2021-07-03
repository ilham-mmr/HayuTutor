import 'package:flutapp/models/tutor_session.dart';
import 'package:flutapp/utils/user_preferences.dart';
import 'package:flutapp/widgets/dismissable_items.dart';
import 'package:flutapp/widgets/session_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class MyTutoringSessions extends StatefulWidget {
  @override
  _MyTutoringSessionsState createState() => _MyTutoringSessionsState();
}

class _MyTutoringSessionsState extends State<MyTutoringSessions> {
  bool isLoading = true;
  int id = UserPreferences.getId();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<TutorSessionProvider>(context, listen: false)
        .getMySessionById(id.toString());

    return Scaffold(
      appBar: AppBar(
        title: Text('My Tutoring Sessions'),
      ),
      body: Consumer<TutorSessionProvider>(
        builder: (context, tutorSession, _) {
          var data = tutorSession.myTutorSessions;
          return data.isNotEmpty
              ? ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, i) {
                    return Dismissible(
                      key: Key(data[i].sessionId.toString()),
                      background: DismissableItems.slideRightBackground(),
                      secondaryBackground:
                          DismissableItems.slideLeftBackground(),
                      onDismissed: (direction) => {
                        if (direction == DismissDirection.endToStart)
                          {
                            _deleteTheSession(
                                context, data[i].sessionId, data[i].tutorId)
                          },
                      },
                      confirmDismiss: (direction) async {
                        bool res = await _confirmDismiss(direction, data[i]);
                        return res;
                      },
                      child: SessionCard(
                        tutorSession: data[i],
                        clickAblePicture: false,
                      ),
                    );
                  },
                )
              : Container(
                  padding: const EdgeInsets.all(18),
                  child: SvgPicture.asset(
                    "assets/images/add_tutor.svg",
                  ),
                );
        },
      ),
    );
  }

  void _deleteTheSession(
      BuildContext context, int sessionId, int userId) async {
    bool isDeleted =
        await Provider.of<TutorSessionProvider>(context, listen: false)
            .deleteTutorSession(sessionId: sessionId, userId: userId);
    if (isDeleted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(milliseconds: 500),
          content: Text('the session has been deleted')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(milliseconds: 500),
          content: Text('failed to delete')));
    }
  }

  Future<bool> _confirmDismiss(
      DismissDirection direction, TutorSession tutorSession) async {
    if (direction == DismissDirection.endToStart) {
      return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Confirm"),
            content: const Text("Are you sure you wish to delete this item?"),
            actions: [
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop(true);
                },
                child: const Text("Delete"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("Cancel"),
              ),
            ],
          );
        },
      );
    } else {
      Navigator.pushNamed(context, '/edit-my-session-screen',
          arguments: tutorSession);
      return false;
    }
  }
}
