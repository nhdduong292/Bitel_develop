import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../../../res/app_images.dart';
import '../../login/login_page.dart';

class DrawerLogic extends GetxController {
  void logOut() {
    Get.offAll(LoginPage());
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
          label: AppLocalizations.of(context)!.textUtilities,
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
