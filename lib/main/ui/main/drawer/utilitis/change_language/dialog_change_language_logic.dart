import 'package:bitel_ventas/main/services/settings_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogChangeLanguageLogic extends GetxController{
  SettingService settingService = Get.find<SettingService>();

  var currentLanguage =
      Get.find<SettingService>().currentLocate.value.languageCode.obs;

  void setLanguageCode(String language) {
    if (!(currentLanguage.value == language)) {
      currentLanguage.value = language;
      update();
    }
  }

  void updateLanguage() {
    if (!(currentLanguage == settingService.currentLocate.value.languageCode)) {
      settingService.updateLocale(
          Locale.fromSubtags(languageCode: currentLanguage.value));
      Get.back();
    } else {
      Get.back();
    }
  }
}