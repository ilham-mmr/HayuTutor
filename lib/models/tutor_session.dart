import 'dart:convert';

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
      this.tutorId,
      this.fullName,
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

// my tutor (users) sessions
  List<TutorSession> _myTutorSessions = [];
  get myTutorSessions {
    return _myTutorSessions;
  }

  Future<bool> getMySessionById(String id) async {
    var url = Uri.parse(
        'https://luxfortis.studio/app/tutors/get_session_by_id.php?id=$id');
    var response = await http.get(url);
    var data = jsonDecode(response.body);

    if (response.statusCode == 200 && data['status'] == 'success') {
      data = data['data']['sessions'];
      var sessions = data
          .map<TutorSession>((item) => TutorSession.fromJson(item))
          .toList();
      _myTutorSessions = sessions;
      notifyListeners();
      return true;
    }
    _myTutorSessions = [];
    notifyListeners();
    return false;
  }

  Future<bool> deleteTutorSession({
    int userId,
    int sessionId,
  }) async {
    var url = Uri.parse(
        'https://luxfortis.studio/app/tutors/delete_session.php?userId=$userId&sessionId=$sessionId');
    var response = await http.get(url);

    if (response.statusCode == 200 && response.body == 'success') {
      _myTutorSessions.removeWhere((element) => element.sessionId == sessionId);
      notifyListeners();
      return true;
    }
    notifyListeners();

    return false;
  }

  Future<bool> updateTutorSession(TutorSession tutorSession) async {
    var url =
        Uri.parse('https://luxfortis.studio/app/tutors/update_session.php');
    var response = await http.post(url, body: {
      'sessionId': tutorSession.sessionId.toString(),
      'userId': tutorSession.tutorId.toString(),
      'subject': tutorSession.subject,
      'duration': tutorSession.duration.toString(),
      'location': tutorSession.location,
      'price': tutorSession.price.toString(),
      'date': tutorSession.date,
      'time': tutorSession.time
    });

    if (response.statusCode == 200 && response.body == 'success') {
      int idx = _myTutorSessions
          .indexWhere((element) => element.sessionId == tutorSession.sessionId);
      _myTutorSessions[idx] = tutorSession;
      notifyListeners();
      return true;
    }

    return false;
  }

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

  // ******
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
    notifyListeners();

    tutorSessionList = [];

    return false;
  }

  getSessionById(String id) async {
    var url = Uri.parse(
        'https://luxfortis.studio/app/tutors/get_session_by_id.php?id=$id');
    var response = await http.get(url);
    var data = jsonDecode(response.body);

    if (response.statusCode == 200 && data['status'] == 'success') {
      data = data['data']['sessions'];
      var sessions = data
          .map<TutorSession>((item) => TutorSession.fromJson(item))
          .toList();
      return sessions;
    }
    return [];
  }

  List tutorSessionSubjectList = [];
  getSessionsBySubject(String keyword) async {
    var url = Uri.parse(
        'https://luxfortis.studio/app/tutors/load_sessions.php?keyword=$keyword');
    var response = await http.get(url);
    var data = jsonDecode(response.body);

    if (response.statusCode == 200 && data['status'] == 'success') {
      data = data['data']['sessions'];
      tutorSessionSubjectList = data
          .map<TutorSession>((item) => TutorSession.fromJson(item))
          .toList();
      return tutorSessionSubjectList;
    }

    return [];
  }

  loadSessions() {}
}
