import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPrefHelper {
  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String prefString = prefs.getString(key);
    return json.decode(prefString);
  }

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
