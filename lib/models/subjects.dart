import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Subject {
  String title;
  String image;

  Subject({this.image, this.title});

  Subject.fromJson(json) {
    title = json['title'];
    image = json['image'];
  }
}

class SubjectProvider with ChangeNotifier {
  getSubjects() async {
    var url = Uri.parse('https://luxfortis.studio/app/subjects/subjects.php');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      data = data['subjects'];

      List<Subject> subjects = data
          .map<Subject>(
              (item) => Subject.fromJson(item))
          .toList();
      // subjects.forEach((e) => print(e.image));
      return subjects;
    } else {
      return <Subject>[];
    }
  }
}
