// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:bitel_ventas/main/networks/model/request_detail_model.dart';
import 'package:bitel_ventas/main/ui/main/activate_prepaid_pages/find_customer_page.dart';
import 'package:bitel_ventas/main/ui/main/drawer/demo_native_page.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/create_request/create_request_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/create_request/dialog_survey_map_page.dart';
import 'package:bitel_ventas/main/utils/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../../../res/app_images.dart';
import '../../../router/route_config.dart';
import '../../login/login_page.dart';

class DrawerLogic extends GetxController {
  RxList<DrawerItem>? listItem = RxList<DrawerItem>();



  void logOut() {
    SharedPreferenceUtil.clearData();
    Get.offAll(LoginPage());
  }

  void onItemClick({required int index, required BuildContext context}) {
    listItem![index].isSelected = true;
    Timer(Duration(milliseconds: 300), () {
      switch (index) {
        case 3:
          // Get.to(() => FindCustomerPage());
          // Get.toNamed(RouteConfig.validateFingerprint);
          showDialogSurveyMap(context);
          break;
        case 2:
          Get.toNamed(RouteConfig.buyAnyPay);
          break;
        // case 4:
        //   // Get.to(DemoNativePage());
        //   Get.toNamed(RouteConfig.validateFingerprint);
        //   break;

      }
    });
  }

  List<DrawerItem> getListItem(BuildContext context) {
    return [
      // DrawerItem(
      //     unselectedImg: AppImages.icMenuManageContact,
      //     label: AppLocalizations.of(context)!.textManageContact,
      //     selectedImg: AppImages.icActivatePrepaidSelected,
      //     isSelected: false,
      //     list: [AppLocalizations.of(context)!.textCreateContact,
      //       AppLocalizations.of(context)!.textManageContact]),
      DrawerItem(
          unselectedImg: AppImages.icMenuFTTH,
          label: AppLocalizations.of(context)!.textFTTH,
          selectedImg: AppImages.icActivatePostpaidSelected,
          isSelected: false,
          list: [
            AppLocalizations.of(context)!.textSale,
            AppLocalizations.of(context)!.textAfterSale,
            // AppLocalizations.of(context)!.textManageWO,
          ]),
      DrawerItem(
          unselectedImg: AppImages.icPortabilityUnselected,
          label: AppLocalizations.of(context)!.textMobile,
          selectedImg: AppImages.icPortabilitySelected,
          isSelected: false,
          list: []),
      DrawerItem(
          unselectedImg: AppImages.icMigrationUnselected,
          label: AppLocalizations.of(context)!.textBuyAnypay,
          selectedImg: AppImages.icMigrationSelected,
          isSelected: false,
          list: []),
      DrawerItem(
          unselectedImg: AppImages.icBuyAnypayUnselected,
          label: AppLocalizations.of(context)!.textClearDebt,
          selectedImg: AppImages.icBuyAnypaySelected,
          isSelected: false,
          list: []),
      DrawerItem(
          unselectedImg: AppImages.icMenuUtilites,
          label: AppLocalizations.of(context)!.textUtilites,
          selectedImg: AppImages.icUtilitiesSelected,
          isSelected: false,
          list: [
            AppLocalizations.of(context)!.textChangeLanguage,
          ])
    ];
  }

  void showDialogSurveyMap(
      BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return DialogSurveyMapPage(
            onSubmit: (isSuccess) {
              // if(isSuccess) {
              //   showDialogSurveySuccessful(context, controller);
              // } else {
              //   showDialogSurveyUnsuccessful(context, controller);
              // }
            },requestModel: RequestDetailModel(),);
        });
  }
}

class DrawerItem {
  String unselectedImg;
  String label;
  String selectedImg;
  bool isSelected;
  List<String>? list;

  DrawerItem(
      {required this.unselectedImg,
      required this.label,
      required this.selectedImg,
      required this.isSelected,
      required this.list});
}
