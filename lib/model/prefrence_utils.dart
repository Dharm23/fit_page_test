import 'package:shared_preferences/shared_preferences.dart';

const String keyScanData = "pre_scan_data";

class PrefrenceUtils {
  static Future<bool> setStringValueWithKey({
    required String key,
    required String value,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(key, value);
  }

  static Future<bool> clearItemForKey(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.remove(key);
  }

  static Future<String?> getStringValueFromKey({
    required String key,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<int?> getIntValueFromKey({required String key}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  static Future<bool> setIntValueWithKey({
    required String key,
    required int value,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setInt(key, value);
  }

  static Future<bool> setDoubleValueWithKey({
    required String key,
    required double value,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setDouble(key, value);
  }

  static Future<double?> getDoubleValueFromKey({required String key}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key);
  }

  static Future<bool> setBoolValueWithKey({
    required String key,
    required bool value,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(key, value);
  }

  static Future<bool> getBoolValueFromKey({required String key}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  static Future<bool> clearAll() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    return true;
  }
}
