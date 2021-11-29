import 'package:crowd_sourced_shopping_app/exports.dart';

class UserPreferences {
  static late SharedPreferences _preferences;
  static const _keyUser = 'user';
  static const myUser = UserProf(
      imagePath: 'https://',
      isDarkMode: false,
      name: '',
      latitude: '',
      longitude: '');

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUser(UserProf user) async {
    final json = jsonEncode(user.toJson());

    await _preferences.setString(_keyUser, json);
  }

  static UserProf getUser() {
    final json = _preferences.getString(_keyUser);

    return json == null ? myUser : UserProf.fromJson(jsonDecode(json));
  }
}
