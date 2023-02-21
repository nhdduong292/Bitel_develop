import 'package:bitel_ventas/res/app_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SaleLogic extends GetxController {
  List<OptionSale> getListOptionSale(BuildContext context) {
    return [
      OptionSale(AppImages.icSaleCreateRequest, AppLocalizations.of(context)!.textCreateRequest),
      OptionSale(AppImages.icSaleConnectSubscriber, AppLocalizations.of(context)!.textConnectSubscriber),
      OptionSale(AppImages.icSaleRechargeAnypay, AppLocalizations.of(context)!.textRechargeAnypay),
      OptionSale(AppImages.icSaleSearchRequest, AppLocalizations.of(context)!.textSearchRequest),
      OptionSale(AppImages.icSaleClearDebt, AppLocalizations.of(context)!.textClearDebt),
      OptionSale(AppImages.icSaleCreateContact, AppLocalizations.of(context)!.textCreateContact),
    ];
  }

  List<OptionSale> getListOptionStaff(BuildContext context) {
    return [
      OptionSale(AppImages.icSaleCreateRequest, AppLocalizations.of(context)!.textAssignTask),
      OptionSale(AppImages.icSaleConnectSubscriber, AppLocalizations.of(context)!.textCompleteTask),
      OptionSale(AppImages.icSaleRechargeAnypay, AppLocalizations.of(context)!.textSearchTask)
    ];
  }
}

class OptionSale {
  String icon;
  String title;

  OptionSale(this.icon, this.title);
}
