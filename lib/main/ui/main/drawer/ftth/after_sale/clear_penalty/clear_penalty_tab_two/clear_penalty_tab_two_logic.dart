import 'dart:async';
import 'dart:math';

import 'package:bitel_ventas/main/ui/main/drawer/clear_debt/clear_debt_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/clear_debt/view_item/search/search_clear_debt_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/ftth/after_sale/clear_penalty/clear_penalty_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ClearPenaltyTabTwoLogic extends GetxController {
  late BuildContext context;

  ClearPenaltyLogic clearDebtLogic = Get.find();

  ClearPenaltyTabTwoLogic({required this.context});

  var countDown = 120.obs;
  bool isActiveButton = false;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    startTimer();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(
      oneSec,
      (Timer timer) {
        if (countDown.value == 0) {
          timer.cancel();
        } else {
          countDown.value--;
        }
      },
    );
  }
}
