import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SaleLogic extends GetxController {
  List<OptionSale> getListOptionSale(BuildContext context) {
    return [
      OptionSale("icon", AppLocalizations.of(context)!.textCreateRequest),
      OptionSale("icon", AppLocalizations.of(context)!.textConnectSubscriber),
      OptionSale("icon", AppLocalizations.of(context)!.textRechargeAnypay),
      OptionSale("icon", AppLocalizations.of(context)!.textSearchRequest),
      OptionSale("icon", AppLocalizations.of(context)!.textClearDebt),
      OptionSale("icon", AppLocalizations.of(context)!.textCreateContact),
    ];
  }

  List<OptionSale> getListOptionStaff(BuildContext context) {
    return [
      OptionSale("icon", AppLocalizations.of(context)!.textAssignTask),
      OptionSale("icon", AppLocalizations.of(context)!.textCompleteTask),
      OptionSale("icon", AppLocalizations.of(context)!.textSearchTask)
    ];
  }
}

class OptionSale {
  String icon;
  String title;

  OptionSale(this.icon, this.title);
}
