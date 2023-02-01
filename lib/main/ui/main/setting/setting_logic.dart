import 'package:bitel_ventas/main/services/settings_service.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class SettingLogic extends GetxController {
  SettingService settingService = Get.find<SettingService>();
  var isSelectHelp = false.obs;
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

  List<SettingModel> getListSetting(BuildContext context) {
    List<SettingModel> list = [
      SettingModel(AppImages.icMyInfo, AppLocalizations.of(context)!.textMyInfo,
          false, []),
      SettingModel(AppImages.icSyncData,
          AppLocalizations.of(context)!.textSyncData, false, []),
      SettingModel(AppImages.icRegisterFinger,
          AppLocalizations.of(context)!.textRegisterFinger, false, []),
      SettingModel(AppImages.icHelp,
          AppLocalizations.of(context)!.textSelectLanguage, false, []),
      SettingModel(
          AppImages.icHelp, AppLocalizations.of(context)!.textHelp, false, [
        AppLocalizations.of(context)!.textChangePass,
        AppLocalizations.of(context)!.textContactUS,
        AppLocalizations.of(context)!.textQuestionsFle
      ])
    ];
    return list;
  }

  void setStateSelectHelp(bool value){
    isSelectHelp.value = value;
    update();
  }
}

class SettingModel {
  String? icon;
  String? title;
  bool isSelect = false;
  List<String>? list;

  SettingModel(this.icon, this.title, this.isSelect, this.list);
}
