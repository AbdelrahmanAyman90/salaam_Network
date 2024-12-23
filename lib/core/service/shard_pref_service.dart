import 'package:halqahquran/core/util/const_varible.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static late SharedPreferences _instance;

  static Future<void> init() async {
    _instance = await SharedPreferences.getInstance();
  }

  static setBool(String key, bool value) {
    _instance.setBool(key, value);
  }

  static bool getBool(String key) {
    if (key == kNotficationIsWork && !_instance.containsKey(key)) {
      return true;
    }
    return _instance.getBool(key) ?? false;
  }

  static setString(String key, String value) {
    _instance.setString(key, value);
  }

  static String getString(String key) {
    return _instance.getString(key) ?? '';
  }

  static Future<void> clearCash() async {
    await _instance.clear();
  }
}
