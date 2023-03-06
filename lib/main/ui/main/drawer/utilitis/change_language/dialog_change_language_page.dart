import 'package:bitel_ventas/main/router/route_config.dart';
import 'package:bitel_ventas/main/ui/main/drawer/utilitis/change_language/dialog_change_language_logic.dart';
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
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                RadioListTile<String>(
                  title: Text(AppLocalizations.of(context)!.textLanguageEN),
                  value: RouteConfig.listLanguage[0].languageCode,
                  groupValue: controller.currentLanguage.value,
                  onChanged: (String? value) {
                    print(value);
                    controller.setLanguageCode(value!);
                  },
                ),
                RadioListTile<String>(
                  title: Text(AppLocalizations.of(context)!.textLanguageVN),
                  value: RouteConfig.listLanguage[1].languageCode,
                  groupValue: controller.currentLanguage.value,
                  onChanged: (String? value) {
                    print(value);
                    controller.setLanguageCode(value!);
                  },
                ),
                RadioListTile<String>(
                  title: Text(AppLocalizations.of(context)!.textLanguageES),
                  value: RouteConfig.listLanguage[2].languageCode,
                  groupValue: controller.currentLanguage.value,
                  onChanged: (String? value) {
                    print(value);
                    controller.setLanguageCode(value!);
                  },
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: ElevatedButton(
                    onPressed: () {
                      controller.updateLanguage();
                    },
                    child: Text(AppLocalizations.of(context)!.textContinue),
                    style: ButtonStyle(
                        foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                        shape:
                        MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: BorderSide(color: Colors.red)))),
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