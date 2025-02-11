import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static setData(String key, dynamic value) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  static getData(String key) async {
    try {
      var prefs = await SharedPreferences.getInstance();
      String? tempData = prefs.getString(key);
      if (tempData != null) {
        return json.decode(tempData);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static removeData(String key) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  static clear(String key) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  static Future<Map<String, dynamic>> getAllData() async {
    var prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> allData = {};

    // 获取所有的键
    for (String key in prefs.getKeys()) {
      String? value = prefs.getString(key);
      if (value != null) {
        allData[key] = json.decode(value);
      }
    }
    return allData;
  }
}
