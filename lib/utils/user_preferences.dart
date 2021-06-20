import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static SharedPreferences _preferences;

  static const _keyId = 'id';
  static const _keyEmail = 'email';
  static const _keyFullName = 'fullname';
  static const _keyPicture = 'picture';
  static const _keyRegistrationDate = 'registrationDate';
  static const _keyRememberMe = 'rememberMe';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();
// email
  static Future setId(int id) async => await _preferences.setInt(_keyId, id);
  static int getId() => _preferences.getInt(_keyId);
  static Future removeId() => _preferences.remove(_keyId);
  // email
  static Future setEmail(String email) async =>
      await _preferences.setString(_keyEmail, email);
  static String getEmail() => _preferences.getString(_keyEmail);
  static Future removeEmail() => _preferences.remove(_keyEmail);
  // fullname
  static Future setFullName(String fullName) async =>
      await _preferences.setString(_keyFullName, fullName);
  static String getFullName() => _preferences.getString(_keyFullName);
  static Future removeFullName() => _preferences.remove(_keyFullName);
  // picture
  static Future setPicture(String picture) async =>
      await _preferences.setString(_keyPicture, picture);
  static String getPicture() => _preferences.getString(_keyPicture);
  static Future removePicture() => _preferences.remove(_keyPicture);
  // regisDate
  static Future setRegistrationDate(String registrationDate) async =>
      await _preferences.setString(_keyRegistrationDate, registrationDate);
  static String getRegistrationDate() =>
      _preferences.getString(_keyRegistrationDate);
  static Future removeRegistrationDate() =>
      _preferences.remove(_keyRegistrationDate);

  // remember me
  static Future setRememberMe(bool rememberMe) async =>
      await _preferences.setBool(_keyRememberMe, rememberMe);
  static bool getRememberMe() => _preferences.getBool(_keyRememberMe);
  static Future removeRememberMe() => _preferences.remove(_keyRegistrationDate);
}
