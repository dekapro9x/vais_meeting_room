import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class BasePrefsStorage {
  SharedPreferences? prefs;

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  T? getValueForKey<T>(String key) {
    if (prefs == null) {
      throw Exception("SharedPreferences chưa được khởi tạo. Hãy gọi init() trước khi sử dụng.");
    }
    return prefs!.get(key) as T?;
  }

  Future<bool> setValueForKey(String key, dynamic value) {
    if (prefs == null) {
      throw Exception("SharedPreferences chưa được khởi tạo. Hãy gọi init() trước khi sử dụng.");
    }

    if (value is int) {
      return prefs!.setInt(key, value);
    }

    if (value is String) {
      return prefs!.setString(key, value);
    }

    if (value is List<String>) {
      return prefs!.setStringList(key, value);
    }

    if (value is bool) {
      return prefs!.setBool(key, value);
    }

    if (value is double) {
      return prefs!.setDouble(key, value);
    }

    final jsonValue = json.encode(value);
    return prefs!.setString(key, jsonValue);
  }

  Future<void> remove({required String key}) async {
    if (prefs == null) {
      throw Exception("SharedPreferences chưa được khởi tạo. Hãy gọi init() trước khi sử dụng.");
    }
    await prefs!.remove(key);
  }
}
