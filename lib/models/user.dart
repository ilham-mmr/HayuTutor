import 'dart:convert';

import 'package:http/http.dart' as http;

class User {
  String _fullName, _email, _registrationDate;

  Future<bool> signUp(String fullname, String email, String password) async {
    var url = Uri.parse('https://luxfortis.studio/app/register_user.php');
    var response = await http.post(url, body: {
      'full_name': fullname.trim(),
      'email': email.trim(),
      'password': password.trim()
    });
    if (response.body == 'success') {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> signIn(String email, String password) async {
    var url = Uri.parse('https://luxfortis.studio/app/login_user.php');
    var response = await http
        .post(url, body: {'email': email.trim(), 'password': password.trim()});
    Map<String, dynamic> data = jsonDecode(response.body);
    if (data['status'] == 'success') {
      _fullName = data['user']['full_name'];
      _email = data['user']['email'];
      _registrationDate = data['user']['registration_date'];
      return true;
    } else {
      return false;
    }
  }
}
