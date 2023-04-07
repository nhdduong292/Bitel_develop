import 'dart:math';

import 'package:bitel_ventas/main/networks/model/clear_debt_model.dart';
import 'package:bitel_ventas/main/ui/main/drawer/clear_debt/clear_debt_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/clear_debt/view_item/search/search_clear_debt_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../networks/api_end_point.dart';
import '../../../../../../networks/api_util.dart';
import '../../../../../../utils/common.dart';
import '../../../../../../utils/common_widgets.dart';

class ClearDebtDetailLogic extends GetxController {
  late BuildContext context;

  var selectService = (-1).obs;
  List<int> listSelect = [];
  double totalService = 0.0;
  bool isActiveButton = false;

  List<ClearDebtModel> listClearDebt = [];

  ClearDebtLogic clearDebtLogic = Get.find();

  ClearDebtDetailLogic({required this.context});

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    listClearDebt = clearDebtLogic.listClearDebt;
  }

  bool isEnoughPayment() {
    // if (clearDebtLogic.balance > totalService) {
    //   return true;
    // } else {
    //   return false;
    // }
    return Random().nextBool();
  }
}
