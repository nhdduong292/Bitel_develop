import 'package:bitel_ventas/main/router/route_config.dart';
import 'package:bitel_ventas/main/ui/main/drawer/utilitis/change_language/dialog_change_language_logic.dart';
import 'package:bitel_ventas/res/app_colors.dart';
import 'package:bitel_ventas/res/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DialogChangeLanguagePage extends Dialog {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DialogChangeLanguageLogic(),
      builder: (controller) {
        return Dialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.all(10),
            color: Colors.white,
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.textSelectLanguage,
                  style: AppStyles.b2.copyWith(fontWeight: FontWeight.bold),),
                RadioListTile<String>(
                  title: Text(AppLocalizations.of(context)!.textLanguageEN, style: AppStyles.r1,),
                  value: RouteConfig.listLanguage[0].languageCode,
                  groupValue: controller.currentLanguage.value,
                  activeColor: AppColors.colorSubContent,
                  onChanged: (String? value) {
                    print(value);
                    controller.setLanguageCode(value!);
                  },
                ),
                RadioListTile<String>(
                  title: Text(AppLocalizations.of(context)!.textLanguageVN, style: AppStyles.r1),
                  value: RouteConfig.listLanguage[1].languageCode,
                  groupValue: controller.currentLanguage.value,
                  activeColor: AppColors.colorSubContent,
                  onChanged: (String? value) {
                    print(value);
                    controller.setLanguageCode(value!);
                  },
                ),
                RadioListTile<String>(
                  title: Text(AppLocalizations.of(context)!.textLanguageES, style: AppStyles.r1),
                  value: RouteConfig.listLanguage[2].languageCode,
                  groupValue: controller.currentLanguage.value,
                  activeColor: AppColors.colorSubContent,
                  onChanged: (String? value) {
                    print(value);
                    controller.setLanguageCode(value!);
                  },
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      controller.updateLanguage();
                    },
                    child: Text(AppLocalizations.of(context)!.textContinue),
                    style: ButtonStyle(
                        foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                        MaterialStateProperty.all<Color>(AppColors.colorButton),
                        shape:
                        MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                                side: BorderSide(color: AppColors.colorButton)))),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}