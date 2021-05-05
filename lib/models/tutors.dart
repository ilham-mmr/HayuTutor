import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum TutorType { DetailTutor, BriefCardTutor }

class Tutor {
  String fullName;
  String picture;
  String location;
  int price;
  String subject;

  Tutor({this.fullName, this.location, this.picture, this.price, this.subject});

  Tutor.fromJson(json, TutorType tutorType) {
    if (tutorType == TutorType.BriefCardTutor) {
      fullName = json['full_name'];
      picture = json['picture'];
      location = json['location'];
      price = json['price'];
      subject = json['subject'];
    } else if (tutorType == TutorType.DetailTutor) {}
  }
}

class TutorProvider with ChangeNotifier {
  getCardTutors() async {
    var url =
        Uri.parse('https://luxfortis.studio/app/tutors/load_cardtutors.php');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      print('im here');
      var data = jsonDecode(response.body);
      data = data['tutors'];
      print(data);
      List<Tutor> tutors = data
          .map<Tutor>((item) => Tutor.fromJson(item, TutorType.BriefCardTutor))
          .toList();
      tutors.forEach((e) => print(e.fullName));
      return tutors;
    } else {
      return <Tutor>[];
    }
  }
}
