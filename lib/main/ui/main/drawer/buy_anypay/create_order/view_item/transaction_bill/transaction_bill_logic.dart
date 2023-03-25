import 'package:bitel_ventas/main/ui/main/drawer/buy_anypay/create_order/create_order_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/clear_debt/clear_debt_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../../utils/common.dart';

class TransactionBillLogic extends GetxController {
  BuildContext context;

  bool isCheckBox = false;
  CreateOrderLogic createOrderLogic = Get.find();

  double amountToBuy = 0.0;

  TransactionBillLogic({required this.context});

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    amountToBuy = createOrderLogic.amountToBuy;
  }
}
