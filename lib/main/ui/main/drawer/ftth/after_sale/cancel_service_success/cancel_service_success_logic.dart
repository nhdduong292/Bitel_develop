import 'package:bitel_ventas/main/networks/model/cancel_service_infor_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CancelServiceSuccessLogic extends GetxController {
  late BuildContext context;

  CancelServiceSuccessLogic({required this.context});

  CancelServiceInforModel model = CancelServiceInforModel();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    var data = Get.arguments;
    model = data[0];
  }
}
