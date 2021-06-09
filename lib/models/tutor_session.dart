import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class TutorSession {
  int sessionId;
  String subject;
  String location;
  double price;
  double duration;
  String date;
  String time;
  int tutorId;
  String fullName;
  String picture;
  TutorSession(
      {this.sessionId,
      this.subject,
      this.location,
      this.price,
      this.date,
      this.time,
      this.duration,
      this.picture});

  TutorSession.fromJson(json) {
    sessionId = json['sessionId'];
    subject = json['subject'];
    location = json['location'];
    price = json['price'].toDouble();
    duration = json['duration'].toDouble();
    date = json['date'];
    time = json['time'];
    tutorId = json['tutorId'];
    fullName = json['fullName'];
    picture = json['picture'];
  }
}

class TutorSessionProvider with ChangeNotifier {
  List<TutorSession> tutorSessionList = [];

  Future<bool> addTutorSession({
    int userId,
    String subject,
    String duration,
    String location,
    String price,
    String date,
    String time,
  }) async {
    var url = Uri.parse('https://luxfortis.studio/app/tutors/add_session.php');
    var response = await http.post(url, body: {
      'userId': userId.toString(),
      'subject': subject,
      'duration': duration,
      'location': location,
      'price': price,
      'date': date,
      'time': time
    });

    if (response.statusCode == 200 && response.body == 'success') {
      return true;
    }

    return false;
  }

  Future<bool> searchSessionByKeyword(String keyword) async {
    var url = Uri.parse(
        'https://luxfortis.studio/app/tutors/load_sessions.php?keyword=$keyword');
    var response = await http.get(url);
    var data = jsonDecode(response.body);

    if (response.statusCode == 200 && data['status'] == 'success') {
      data = data['data']['sessions'];
      tutorSessionList = data
          .map<TutorSession>((item) => TutorSession.fromJson(item))
          .toList();
      notifyListeners();
      return true;
    }
    tutorSessionList = [];

    return false;
  }

  loadSessions() {}
}
