import 'package:bitel_ventas/main/networks/model/cancel_service_model.dart';
import 'package:bitel_ventas/main/networks/model/find_account_model.dart';
import 'package:bitel_ventas/main/ui/main/drawer/ftth/after_sale/after_sale_search_logic.dart';
import 'package:bitel_ventas/main/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../networks/api_end_point.dart';
import '../../../../../../networks/api_util.dart';
import '../../../../../../utils/common_widgets.dart';

class ChooseServiceLogic extends GetxController {
  AfterSaleSearchLogic afterSaleSearchLogic = Get.find();
  bool isActive = true;
  List<FindAccountModel> listAccount = [];
  var valueService = (-1).obs;
  CancelServiceModel cancelServiceModel = CancelServiceModel();

  BuildContext context;

  ChooseServiceLogic({required this.context});

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    listAccount = afterSaleSearchLogic.listAccount;
    update();
  }

  void setActive(bool value) {
    isActive = value;
    update();
  }

  void requestCanncel(var onSuccess) {
    _onLoading(context);
    Map<String, dynamic> body = {
      'subId': listAccount[valueService.value].subId,
      'cancelDate': '',
    };
    ApiUtil.getInstance()!.post(
      url: ApiEndPoints.API_REQUEST_CANNCEL.replaceAll(
          'subId', listAccount[valueService.value].subId.toString()),
      body: body,
      onSuccess: (response) {
        Get.back();
        if (response.isSuccess) {
          cancelServiceModel =
              CancelServiceModel.fromJson(response.data['data']);
          onSuccess(true);
        } else {
          print("error: ${response.status}");
          onSuccess(false);
        }
        update();
      },
      onError: (error) {
        Get.back();
        onSuccess(false);
        Common.showMessageError(error: error, context: context);
      },
    );
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
}
