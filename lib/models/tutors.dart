import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum TutorType { DetailTutor, BriefCardTutor }

class Tutor with ChangeNotifier {
  int tutorId;
  String fullName;
  String picture;
  String location;
  int price;
  String subject;

  Tutor({
    this.tutorId,
    this.fullName,
    this.location,
    this.picture,
    this.price,
    this.subject,
  });

  Tutor.fromJson(json, TutorType tutorType) {
    if (tutorType == TutorType.BriefCardTutor) {
      tutorId = json['tutorId'];
      fullName = json['full_name'];
      picture = json['picture'];
      location = json['location'];
      price = json['price'];
      subject = json['subject'];
    } else if (tutorType == TutorType.DetailTutor) {}
  }
}

class TutorProvider with ChangeNotifier {
  List<Tutor> tutors;
  getCardTutors() async {
    var url =
        Uri.parse('https://luxfortis.studio/app/tutors/load_cardtutors.php');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      data = data['tutors'];
      tutors = data
          .map<Tutor>((item) => Tutor.fromJson(item, TutorType.BriefCardTutor))
          .toList();
      // tutors.forEach((e) => print(e.fullName));
      return tutors;
    }
    return <Tutor>[];
  }
}

class FavoriteTutorListProvider with ChangeNotifier {
  List<Tutor> _favoriteList = [];
  List<Tutor> get favoriteList {
    return _favoriteList;
  }

  _saveToPrefs() async {
    // var s = json.encode(_favoriteList);
    // var data = json.decode(s);
    // print(data);
//  SharedPreferences prefs = await SharedPreferences.getInstance();
//  prefs.
  }

  addToFavoriteList(Tutor tutor) {
    bool found = false;
    print(tutor.tutorId);
    _saveToPrefs();
    _favoriteList.forEach((element) {
      if (element.tutorId == tutor.tutorId) {
        found = true;
      }
    });

    if (!found) {
      _favoriteList.add(tutor);
      notifyListeners();
      return true;
    }

    notifyListeners();
    return false;
  }

  deleteFromFavoriteList(int id) {
    bool found = false;
    _favoriteList.forEach((element) {
      if (element.tutorId == id) {
        found = true;
      }
    });

    if (found) {
      _favoriteList.removeWhere((element) => element.tutorId == id);
    }
    notifyListeners();
  }
}
