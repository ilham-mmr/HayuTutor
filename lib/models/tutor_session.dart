import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class TutorSession {
  int sessionId;
  String subject;
  String location;
  double price;
  String date;
  String time;
  int tutorId;
  TutorSession(
      {this.sessionId,
      this.subject,
      this.location,
      this.price,
      this.date,
      this.time});

  TutorSession.fromJson(json) {
    sessionId = json['sessionId'];
    subject = json['subject'];
    location = json['location'];
    price = json['price'];
    date = json['date'];
    time = json['time'];
    tutorId = json['tutorId'];
  }
}

class TutorSessionProvider with ChangeNotifier {
  Future<bool> addTutorSession(
      {int userId,
      String subject,
      String duration,
      String location,
      String price,
      String date,
      String time}) async {
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
}
