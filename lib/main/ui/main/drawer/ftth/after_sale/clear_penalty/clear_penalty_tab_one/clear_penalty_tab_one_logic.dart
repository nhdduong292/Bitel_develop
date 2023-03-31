import 'dart:math';

import 'package:bitel_ventas/main/ui/main/drawer/clear_debt/clear_debt_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/clear_debt/view_item/search/search_clear_debt_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/ftth/after_sale/clear_penalty/clear_penalty_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ClearPenaltyTabOneLogic extends GetxController {
  late BuildContext context;

  var selectService = (-1).obs;
  List<int> listSelect = [];
  var isSelect = false.obs;

  DetailServiceModel detailServiceModel = DetailServiceModel();
  // DetailServiceModel detailServiceModel2 = DetailServiceModel();

  // List<DetailServiceModel> listDetailService = [];
  double totalService = 0.0;
  bool isActiveButton = false;

  ClearPenaltyLogic clearDebtLogic = Get.find();

  ClearPenaltyTabOneLogic({required this.context});

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
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

class DetailServiceModel {
  String type = 'Postpago';
  String plan = 'iChip + 39.90';
  String number = '910345699';
  String idType = 'DNI';
  String idNumber = '910399';
  String name = 'Diego Guadalupe C.';
  String condition = 'Active';
  double receiptNumber = 39.90;
  String bankNumber = '010345699096';
  String vence = '25/04';
}
