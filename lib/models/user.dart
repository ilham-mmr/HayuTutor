import 'dart:convert';
import 'package:flutapp/utils/user_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class User with ChangeNotifier {
  int id;
  String fullName, email, registrationDate, picture;
  String _forgotOtp, _forgotEmail;
  bool isTutor;

  Future<bool> signUp(String fullname, String email, String password,
      String encodedBase64string) async {
    var url = Uri.parse('https://luxfortis.studio/app/register_user.php');
    var response = await http.post(url, body: {
      'full_name': fullname.trim(),
      'email': email.trim(),
      'password': password.trim(),
      'encoded_base64string': encodedBase64string
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
      id = data['user']['id'];
      fullName = data['user']['full_name'];
      email = data['user']['email'];
      registrationDate = data['user']['registration_date'];
      picture = data['user']['picture'];
      isTutor = data['user']['isTutor'] == 1 ? true : false;
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateProfile(
      int id, String fullName, String encodedBase64string) async {
    var url = Uri.parse('https://luxfortis.studio/app/update_user_profile.php');

    Map body = {
      'id': id.toString(),
      'fullName': fullName,
    };

    if (encodedBase64string.isNotEmpty) {
      body['encoded_base64string'] = encodedBase64string;
    }
    print(body);
    var response = await http.post(url, body: body);
    Map<String, dynamic> data = jsonDecode(response.body);
    print(data);

    if (data['status'] == 'success') {
      id = data['user']['id'];
      fullName = data['user']['full_Name'];
      picture = data['user']['picture'];

      notifyListeners();
      return true;
    }

    return false;
  }

  Future<bool> forgotPassword(String email) async {
    var url = Uri.parse('https://luxfortis.studio/app/reset_password.php');
    var response = await http.post(url, body: {'email': email.trim()});
    var data = jsonDecode(response.body);
    if (data['status'] == 'success') {
      _forgotOtp = data['data']['otp'].toString();
      _forgotEmail = data['data']['email'];

      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> setPassword(String email, String otp, String password) async {
    var url = Uri.parse('https://luxfortis.studio/app/set_password.php');
    var response = await http
        .post(url, body: {'email': email, 'otp': otp, 'password': password});

    return response.body == 'success' ? true : false;
  }

  String get forgotOtp {
    return _forgotOtp;
  }

  String get forgotEmail {
    return _forgotEmail;
  }
}
