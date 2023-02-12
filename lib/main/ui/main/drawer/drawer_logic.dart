// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:bitel_ventas/main/ui/main/activate_prepaid_pages/find_customer_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../../../res/app_images.dart';
import '../../../router/route_config.dart';
import '../../login/login_page.dart';

class DrawerLogic extends GetxController {
  RxList<DrawerItem>? listItem = RxList<DrawerItem>();



  void logOut() {
    Get.offAll(LoginPage());
  }

  void onItemClick({required int index}) {
    listItem![index].isSelected = true;
    Timer(Duration(milliseconds: 300), () {
      switch (index) {
        case 3:
          Get.to(() => FindCustomerPage());
          break;
        case 2:
          Get.toNamed(RouteConfig.listRequest);
          break;
      }
    });
  }

  List<DrawerItem> getListItem(BuildContext context) {
    return [
      DrawerItem(
          unselectedImg: AppImages.icMenuManageContact,
          label: AppLocalizations.of(context)!.textManageContact,
          selectedImg: AppImages.icActivatePrepaidSelected,
          isSelected: false,
          list: [AppLocalizations.of(context)!.textCreateContact,
            AppLocalizations.of(context)!.textManageContact]),
      DrawerItem(
          unselectedImg: AppImages.icMenuFTTH,
          label: AppLocalizations.of(context)!.textFTTH,
          selectedImg: AppImages.icActivatePostpaidSelected,
          isSelected: false,
          list: [
            AppLocalizations.of(context)!.textSale,
            AppLocalizations.of(context)!.textAfterSale,
            AppLocalizations.of(context)!.textManageWO,
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
          label: AppLocalizations.of(context)!.textUtilities,
          selectedImg: AppImages.icUtilitiesSelected,
          isSelected: false,
          list: [
            AppLocalizations.of(context)!.textChangeLanguage,
          ])
    ];
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
