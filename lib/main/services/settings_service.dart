import 'dart:ui';

import 'package:bitel_ventas/main/networks/model/user_model.dart';
import 'package:bitel_ventas/main/ui/main/drawer/utilitis/info_bussiness.dart';
import 'package:bitel_ventas/main/utils/common.dart';
import 'package:bitel_ventas/main/utils/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

extension ThemeModeExtension on ThemeMode {
  String get code {
    switch (this) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      default:
        return 'system';
    }
  }

  static ThemeMode fromCode(String code) {
    switch (code) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}

class SettingService extends GetxService {
  // Theme
  final Rx<ThemeMode> currentThemeMode = ThemeMode.system.obs;

  // Language
  final Rx<Locale> currentLocate =
      const Locale.fromSubtags(languageCode: 'es').obs;

  late SharedPreferences prefs;

  final Rx<String> token = "".obs;
  Rx<String> version = "1.0.14".obs;

  Future<SettingService> init() async {
    prefs = await SharedPreferences.getInstance();

    ///ThemeMode
    String themeModeCode =
        prefs.getString("themeModeCode") ?? ThemeMode.system.code;
    final themeMode = ThemeModeExtension.fromCode(themeModeCode);
    currentThemeMode.value = themeMode;
    Get.changeThemeMode(themeMode);

    ///Language
    String languageCode = prefs.getString("languageCodeCurrent") ?? 'es';
    // var locale = S.delegate.supportedLocales.firstWhere(
    //       (element) => element.languageCode == languageCode,
    //   orElse: () => Locale.fromSubtags(languageCode: "en"),
    // );
    var locale = Locale.fromSubtags(languageCode: languageCode);
    currentLocate.value = locale;
    Get.updateLocale(locale);
    // version.value = packageInfo.version;

    int timeRefreshToken = prefs.getInt(SPrefCache.PREF_KEY_REFRESH_TOKEN) ??
        DateTime.now().millisecondsSinceEpoch;
    int timeCurrent = DateTime.now().millisecondsSinceEpoch;
    int result = timeCurrent - timeRefreshToken;
    if (result < Common.DAY && result > 0) {
      token.value = prefs.getString(SPrefCache.KEY_TOKEN) ?? "";
      if (token.value.isNotEmpty) {
        Map<String, dynamic> payload = Jwt.parseJwt(token.value);
        // Print the payload
        InfoBusiness.getInstance()!.setUser(UserModel.fromJson(payload));
      }
    }
    return this;
  }

  void changeThemeMode(ThemeMode themeMode) async {
    prefs.setString('themeModeCode', themeMode.code);
    currentThemeMode.value = themeMode;
    Get.changeThemeMode(themeMode);
  }

  void updateLocale(Locale locale) async {
    // var newLocale = S.delegate.supportedLocales.firstWhere(
    //       (element) => element.languageCode == locale.languageCode,
    //   orElse: () => Locale.fromSubtags(languageCode: "en"),
    // );
    prefs.setString('languageCodeCurrent', locale.languageCode);
    currentLocate.value = locale;
    Get.updateLocale(locale);
  }

  bool getToken() {
    if (token.value.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
}
