import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class User with ChangeNotifier {
  String _fullName, _email, _registrationDate, _picture;
  String _forgotOtp, _forgotEmail;

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
      _fullName = data['user']['full_name'];
      _email = data['user']['email'];
      _registrationDate = data['user']['registration_date'];
      _picture = data['user']['picture'];
      notifyListeners();
      return true;
    } else {
      return false;
    }
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

  String get fullname {
    return _fullName;
  }

  String get email {
    return _email;
  }

  String get registrationDate {
    return _registrationDate;
  }

  String get picture {
    return _picture;
  }
}
