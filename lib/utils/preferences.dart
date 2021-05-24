import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  Preference._();

  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  /// ----------------------------------------------------------
  /// Generic routine to fetch an application preference
  /// ----------------------------------------------------------
  static Future<String> getItem(String name) async {
    final SharedPreferences prefs = await _prefs;

    return prefs.getString(name) ?? '';
  }

  static Future<int> getInt(String name) async {
    final SharedPreferences prefs = await _prefs;

    return prefs.getInt(name) ?? 0;
  }

  /// ----------------------------------------------------------
  /// Generic routine to saves an application preference
  /// ----------------------------------------------------------
  static Future<bool> setItem(String name, String value) async {
    final SharedPreferences prefs = await _prefs;

    return prefs.setString(name, value);
  }

  static Future<bool> setInt(String name, int value) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.setInt(name, value);
  }

  static Future<Set<String>> getAll() async {
    final SharedPreferences prefs = await _prefs;

    return prefs.getKeys();
  }
}
