import 'package:bitel_ventas/main/networks/model/buy_anypay_comfirm_model.dart';
import 'package:bitel_ventas/main/networks/model/buy_anypay_create_model.dart';
import 'package:bitel_ventas/main/ui/main/drawer/buy_anypay/create_order/create_order_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/clear_debt/clear_debt_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../../networks/api_end_point.dart';
import '../../../../../../../networks/api_util.dart';
import '../../../../../../../utils/common.dart';
import '../../../../../../../utils/common_widgets.dart';

class TransactionBillLogic extends GetxController {
  BuildContext context;

  bool isCheckBox = false;
  CreateOrderLogic createOrderLogic = Get.find();

  BuyAnyPayCreateModel buyAnyPayCreateModel = BuyAnyPayCreateModel();

  TransactionBillLogic({required this.context});

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    buyAnyPayCreateModel = createOrderLogic.buyAnyPayCreateModel;
  }

  String getCreationDate(String? date) {
    if (date != null) {
      return Common.fromDate(DateTime.parse(date), 'dd/MM/yyyy');
    }
    return '---';
  }
}
