import 'package:bitel_ventas/main/networks/model/find_account_model.dart';
import 'package:bitel_ventas/main/networks/model/request_detail_model.dart';
import 'package:bitel_ventas/main/ui/main/drawer/ftth/after_sale/after_sale_search_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/ftth/after_sale/date_cancel_service/date_cancel_service.dart';
import 'package:bitel_ventas/main/ui/main/drawer/ftth/after_sale/date_cancel_service/date_cancel_service_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/ftth/after_sale/transfer_service/bill_transfer_service_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransferServicePDFLogic extends GetxController {
  BuildContext context;

  var checkOption = true.obs;
  int requestId = 0;
  TransferServicePDFLogic({required this.context});
  RequestDetailModel requestDetailModel = RequestDetailModel();
  BillTransferServiceLogic billTransferServiceLogic = Get.find();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    requestDetailModel = billTransferServiceLogic.requestDetailModel;
    requestId = billTransferServiceLogic.requestId;
  }
}
