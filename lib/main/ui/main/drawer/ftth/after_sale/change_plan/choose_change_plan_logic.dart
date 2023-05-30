import 'package:bitel_ventas/main/networks/model/find_account_model.dart';
import 'package:bitel_ventas/main/networks/model/product_change_plan_model.dart';
import 'package:bitel_ventas/main/networks/model/reasons_cancel_service_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../networks/api_end_point.dart';
import '../../../../../../networks/api_util.dart';
import '../../../../../../networks/model/cancel_service_model.dart';
import '../../../../../../utils/common.dart';
import '../../../../../../utils/common_widgets.dart';

class ChooseChangePlanLogic extends GetxController {
  BuildContext context;

  ChooseChangePlanLogic({required this.context});

  ProductChangePlanModel productChangePlanModel = ProductChangePlanModel();
  var valueProduct = (-1).obs; // index cua product

  int subId = 0;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    var data = Get.arguments;
    subId = data[0];
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getProduct();
  }

  void _onLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: LoadingCirculApi(),
        );
      },
    );
  }

  void getProduct() {
    _onLoading(context);
    ApiUtil.getInstance()!.get(
      url: ApiEndPoints.API_GET_PRODUCT_CHANGE_PLAN,
      params: {"subId": subId},
      onSuccess: (response) {
        Get.back();
        if (response.isSuccess) {
          productChangePlanModel =
              ProductChangePlanModel.fromJson(response.data['data']);
          update();
          print(response.data['data']);
        } else {
          print("error: ${response.status}");
        }
      },
      onError: (error) {
        Get.back();
        Common.showMessageError(error: error, context: context);
      },
    );
  }
}
