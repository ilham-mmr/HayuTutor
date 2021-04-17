import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static SharedPreferences _preferences;

  static const _keyEmail = 'email';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setEmail(String email) async =>
      await _preferences.setString(_keyEmail, email);

  static String getEmail() => _preferences.getString(_keyEmail);
}
