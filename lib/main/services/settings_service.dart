import 'dart:ui';

import 'package:bitel_ventas/main/utils/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  final Rx<Locale> currentLocate = window.locale.obs;

  late SharedPreferences prefs;

  final Rx<String> token = "".obs;

  Future<SettingService> init() async {
    prefs = await SharedPreferences.getInstance();

    ///ThemeMode
    String themeModeCode = prefs.getString("themeModeCode") ?? ThemeMode.system.code;
    final themeMode = ThemeModeExtension.fromCode(themeModeCode);
    currentThemeMode.value = themeMode;
    Get.changeThemeMode(themeMode);

    ///Language
    String languageCode = prefs.getString("languageCode") ?? window.locale.languageCode;
    // var locale = S.delegate.supportedLocales.firstWhere(
    //       (element) => element.languageCode == languageCode,
    //   orElse: () => Locale.fromSubtags(languageCode: "en"),
    // );
    var locale = Locale.fromSubtags(languageCode: languageCode);
    currentLocate.value = locale;
    Get.updateLocale(locale);

    token.value = prefs.getString(SPrefCache.KEY_TOKEN) ?? "";

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
    prefs.setString('languageCode', locale.languageCode);
    currentLocate.value = locale;
    Get.updateLocale(locale);
  }

  bool getToken(){
    if(token.value.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
}
