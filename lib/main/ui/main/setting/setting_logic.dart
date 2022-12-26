import 'dart:ffi';
import 'dart:ui';

import 'package:bitel_ventas/main/services/settings_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SettingLogic extends GetxController {
  SettingService settingService = Get.find<SettingService>();
  var currentLanguage = Get.find<SettingService>().currentLocate.value.languageCode.obs;

  void setLanguageCode(String language) {
    if (!(currentLanguage.value == language)) {
      currentLanguage.value = language;
      update();
    }
  }

  void updateLanguage() {
    if (!(currentLanguage ==
        settingService.currentLocate.value.languageCode)) {
      settingService.updateLocale(Locale.fromSubtags(languageCode: currentLanguage.value));
      Get.back();
    }
  }

  List<SettingModel> getListSetting(BuildContext context){
    List<SettingModel> list = [
      SettingModel("icon", "title", false, []),
      SettingModel("icon", "title", false, []),
      SettingModel("icon", "title", false, []),
      SettingModel("icon", "title", false, []),
      SettingModel("icon", "title", false, [])
    ];
    return list;
  }
}

class SettingModel{
  String? icon;
  String? title;
  bool isSelect = false;
  List<String>? list;

  SettingModel(this.icon, this.title, this.isSelect, this.list);
}
