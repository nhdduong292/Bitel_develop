import 'package:bitel_ventas/main/custom_views/line_dash.dart';
import 'package:bitel_ventas/main/router/route_config.dart';
import 'package:bitel_ventas/main/ui/main/setting/setting_logic.dart';
import 'package:bitel_ventas/res/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../res/app_colors.dart';
import '../../../../res/app_styles.dart';

class SettingPage extends GetView<SettingLogic> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GetBuilder(
      init: SettingLogic(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Configuración", style: AppStyles.title),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      SvgPicture.asset(AppImages.icTimeBar),
                      SizedBox(
                        width: 5,
                      ),
                      Text("28/12/2020 07:30 - V1.1", style: AppStyles.b1),
                      SizedBox(
                        width: 20,
                      ),
                      SvgPicture.asset(AppImages.icAccountBar),
                      SizedBox(
                        width: 5,
                      ),
                      Text("GUADALUPECC-LI4", style: AppStyles.b1)
                    ],
                  )
                ],
              ),
            ),
            toolbarHeight: 100,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  color: AppColors.colorBackground,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.elliptical(width / 2, 20),
                      bottomRight: Radius.elliptical(width / 2, 20))),
            ),
          ),
          body: Container(
            child: ListView.builder(
              itemCount: controller.getListSetting(context).length,
              itemBuilder: (context, index) {
                SettingModel settingModel =
                    controller.getListSetting(context)[index];
                if (settingModel.list!.isEmpty) {
                  return GestureDetector(
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 15, left: 15, right: 15),
                      padding: EdgeInsets.only(
                          left: 22, top: 13, bottom: 13, right: 22),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 1),
                            blurRadius: 2,
                            color: Colors.black.withOpacity(0.3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SvgPicture.asset(settingModel.icon!),
                          SizedBox(
                            width: 22,
                          ),
                          Expanded(
                              child: Text(
                            settingModel.title!,
                            style: AppStyles.r1,
                          )),
                          SvgPicture.asset(AppImages.icOvalArrowRight)
                        ],
                      ),
                    ),
                    onTap: () {
                      if (index == 0) {
                        Get.toNamed(RouteConfig.myInfo);
                      } else if (index == 1) {
                        Get.toNamed(RouteConfig.syncData);
                      } else if (index == 2) {
                        Get.toNamed(RouteConfig.registerFinger);
                      } else if (index == 3) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return DialogLanguage();
                          },
                        );
                      }
                    },
                  );
                } else {
                  return Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 30, left: 15, right: 15),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 1),
                          blurRadius: 2,
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ],
                    ),
                    child: ExpansionTile(
                      trailing: controller.isSelectHelp.value
                          ? SvgPicture.asset(AppImages.icOvalArrowDown)
                          : SvgPicture.asset(AppImages.icOvalArrowRight),
                      leading: SvgPicture.asset(AppImages.icHelp),
                      title: Text(settingModel.title!,
                          style: AppStyles.r1.copyWith(
                              color: controller.isSelectHelp.value
                                  ? AppColors.colorContent
                                  : AppColors.colorText1)),
                      children: <Widget>[
                        Column(
                          children: _buildExpandableContent(settingModel),
                        ),
                      ],
                      onExpansionChanged: (value) {
                        controller.setStateSelectHelp(value);
                      },
                    ),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }

  _buildExpandableContent(SettingModel vehicle) {
    List<Column> columnContent = [];
    for (int i = 0; i < vehicle.list!.length; i++) {
      String content = vehicle.list![i];
      columnContent.add(Column(
        children: [
          const LineDash(color: AppColors.colorLineDash),
          Padding(
            padding: const EdgeInsets.only(left: 58, right: 8),
            child: ListTile(
              title: Text(
                content,
                style: AppStyles.r1,
              ),
              trailing: SvgPicture.asset(AppImages.icArrowRight),
              onTap: () {
                if (i == 0) {
                  print("index: $i");
                } else if (i == 1) {
                  print("index: $i");
                } else if (i == 2) {
                  print("index: $i");
                }
              },
            ),
          )
        ],
      ));
    }
    return columnContent;
  }
}

class DialogLanguage extends Dialog {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SettingLogic(),
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
