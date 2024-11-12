import 'package:shared_preferences/shared_preferences.dart';

class SPData {
  static Future<E?> load<E>(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(key) as E?;
  }

  static Future save<E>(String key, E value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      switch (value.runtimeType) {
        case const (bool):
          return await prefs.setBool(key, value as bool);
        case const (int):
          return await prefs.setInt(key, value as int);
        case const (String):
          return await prefs.setString(key, value as String);
        default:
          return null;
      }
    } catch (e) {
      return e;
    }
  }

  static Future<bool> reset() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      return await prefs.clear();
    } catch (e) {
      return false;
    }
  }
}
