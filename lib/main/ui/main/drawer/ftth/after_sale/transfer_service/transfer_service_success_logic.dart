import 'package:bitel_ventas/main/networks/model/cancel_service_infor_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../networks/model/transfer_service_infor_model.dart';

class TransferServiceSuccessLogic extends GetxController {
  late BuildContext context;

  TransferServiceSuccessLogic({required this.context});

  TransferServiceInforModel model = TransferServiceInforModel();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    var data = Get.arguments;
    model = data[0];
  }
}
