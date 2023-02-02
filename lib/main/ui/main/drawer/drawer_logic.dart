// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:bitel_ventas/main/ui/main/activate_prepaid_pages/find_customer_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../../../res/app_images.dart';
import '../../login/login_page.dart';

class DrawerLogic extends GetxController {
  var item = DrawerItem(
          unselectedImg: '', label: '', selectedImg: '', isSelected: false)
      .obs;
  RxList<DrawerItem>? listItem = RxList<DrawerItem>();



  void logOut() {
    Get.offAll(LoginPage());
  }

  void onItemClick({required int index}) {
    listItem![index].isSelected = true;
    Timer(Duration(milliseconds: 300), () {
      Get.back();
      switch (index) {
        case 0:
          Get.to(() => FindCustomerPage());
      }
    });
  }

  List<DrawerItem> getListItem(BuildContext context) {
    return [
      DrawerItem(
          unselectedImg: AppImages.icActivatePrepaidUnselected,
          label: AppLocalizations.of(context)!.textActivatePrepaid,
          selectedImg: AppImages.icActivatePrepaidSelected,
          isSelected: false),
      DrawerItem(
          unselectedImg: AppImages.icActivatePostpaidUnselected,
          label: AppLocalizations.of(context)!.textActivatePostpaid,
          selectedImg: AppImages.icActivatePostpaidSelected,
          isSelected: false),
      DrawerItem(
          unselectedImg: AppImages.icPortabilityUnselected,
          label: AppLocalizations.of(context)!.textPortability,
          selectedImg: AppImages.icPortabilitySelected,
          isSelected: false),
      DrawerItem(
          unselectedImg: AppImages.icMigrationUnselected,
          label: AppLocalizations.of(context)!.textMigration,
          selectedImg: AppImages.icMigrationSelected,
          isSelected: false),
      DrawerItem(
          unselectedImg: AppImages.icBuyAnypayUnselected,
          label: AppLocalizations.of(context)!.textAnyPay,
          selectedImg: AppImages.icBuyAnypaySelected,
          isSelected: false),
      DrawerItem(
          unselectedImg: AppImages.icUtilitiesUnselected,
          label: AppLocalizations.of(context)!.textUtilities,
          selectedImg: AppImages.icUtilitiesSelected,
          isSelected: false),
      DrawerItem(
          unselectedImg: AppImages.icSaleOfPackagesUnselected,
          label: AppLocalizations.of(context)!.textSaleOfPackages,
          selectedImg: AppImages.icSaleOfPackagesSelected,
          isSelected: false),
    ];
  }
}

class DrawerItem {
  String unselectedImg;
  String label;
  String selectedImg;
  bool isSelected;

  DrawerItem(
      {required this.unselectedImg,
      required this.label,
      required this.selectedImg,
      required this.isSelected});
}
