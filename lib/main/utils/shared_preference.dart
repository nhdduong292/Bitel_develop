import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SPrefCache {
  // share preference key
  static const String KEY_TOKEN = "auth_token";
  static const String PREF_KEY_LANGUAGE = "pref_key_language";
  static const String PREF_KEY_USER_INFO = "pref_key_user_info";
  static const String PREF_KEY_IS_KEEP_LOGIN = "pref_key_is_keep_login";
}

class SharedPreferenceUtil {
  static Future saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(SPrefCache.KEY_TOKEN, token);
  }

  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(SPrefCache.KEY_TOKEN) ?? '';
  }

  static Future saveKeepLogin(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(SPrefCache.PREF_KEY_IS_KEEP_LOGIN, value);
  }

  static Future<bool> isKeepLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(SPrefCache.PREF_KEY_IS_KEEP_LOGIN) ?? false;
  }

  static Future saveUserInfo(user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(SPrefCache.PREF_KEY_USER_INFO, json.encode(user));
  }

//  static Future<LoginResponse> getUserInfo() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    var data = prefs.getString(SPrefCache.PREF_KEY_USER_INFO);
//    if (data == null) {
//      return null;
//    }
//    return LoginResponse.fromMap(json.decode(data));
//  }

  static Future clearData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
