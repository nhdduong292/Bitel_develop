import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SPrefCache {
  // share preference key
  static const String KEY_TOKEN = "auth_token";
  static const String PREF_KEY_LANGUAGE = "pref_key_language";
  static const String PREF_KEY_USER_INFO = "pref_key_user_info";
  static const String PREF_KEY_IS_KEEP_LOGIN = "pref_key_is_keep_login";
  static const String PREF_KEY_REMEMBER_ACCOUNT = "pref_key_remember_account";
  static const String PREF_KEY_USER_NAME = "pref_key_user_name";
  static const String PREF_KEY_PASS_WORD = "pref_key_pass_word";
  static const String PREF_KEY_REFRESH_TOKEN = "pref_key_refresh_token";
}

class SharedPreferenceUtil {

  static Future saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(SPrefCache.KEY_TOKEN, token);
  }

  static Future<String> getToken()  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(SPrefCache.KEY_TOKEN) ?? "";
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

 // static Future<LoginResponse> getUserInfo() async {
 //   SharedPreferences prefs = await SharedPreferences.getInstance();
 //   var data = prefs.getString(SPrefCache.PREF_KEY_USER_INFO);
 //   if (data == null) {
 //     return null;
 //   }
 //   return LoginResponse.fromMap(json.decode(data));
 // }
  static Future saveRememberAccount(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(SPrefCache.PREF_KEY_REMEMBER_ACCOUNT, value);
  }

  static Future<bool> isRememberAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(SPrefCache.PREF_KEY_REMEMBER_ACCOUNT) ?? false;
  }

  static Future saveUserName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(SPrefCache.PREF_KEY_USER_NAME, name);
  }

  static Future<String> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(SPrefCache.PREF_KEY_USER_NAME) ?? "";
  }

  static Future savePassWord(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(SPrefCache.PREF_KEY_PASS_WORD, name);
  }

  static Future<String> getPassWord() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(SPrefCache.PREF_KEY_PASS_WORD) ?? "";
  }

  static Future clearData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future saveRefreshToken(int name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(SPrefCache.PREF_KEY_REFRESH_TOKEN, name);
  }

  static Future<int> getRefreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(SPrefCache.PREF_KEY_REFRESH_TOKEN) ?? DateTime.now().millisecondsSinceEpoch;
  }
}
