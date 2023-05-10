import 'package:bitel_ventas/main/networks/model/find_account_model.dart';
import 'package:bitel_ventas/main/ui/main/drawer/ftth/after_sale/after_sale_search_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/ftth/after_sale/date_cancel_service/date_cancel_service.dart';
import 'package:bitel_ventas/main/ui/main/drawer/ftth/after_sale/date_cancel_service/date_cancel_service_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CancelServicePDFLogic extends GetxController {
  BuildContext context;

  var checkOption = false.obs;
  int orderId = 0;
  FindAccountModel findAccountModel = FindAccountModel();
  CancelServicePDFLogic({required this.context});
  DateCancelServiceLogic dateCancelServiceLogic = Get.find();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    var data = Get.arguments;
    orderId = data[0];
    findAccountModel = dateCancelServiceLogic.findAccountModel;
  }
}
