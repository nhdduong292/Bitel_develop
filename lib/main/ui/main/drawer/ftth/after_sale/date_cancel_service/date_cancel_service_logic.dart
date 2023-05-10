import 'package:bitel_ventas/main/networks/model/find_account_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../networks/api_end_point.dart';
import '../../../../../../networks/api_util.dart';
import '../../../../../../networks/model/cancel_service_model.dart';
import '../../../../../../utils/common.dart';
import '../../../../../../utils/common_widgets.dart';

class DateCancelServiceLogic extends GetxController {
  BuildContext context;
  FindAccountModel findAccountModel = FindAccountModel();
  bool isActive = true;
  DateTime selectDate = DateTime.now();
  DateTime? datePicker;
  var fromDate = "".obs;
  var toDate = "".obs;
  bool isCheckAgree = true;
  String cancelDate = '';
  DateCancelServiceLogic({required this.context});
  CancelServiceModel cancelServiceModel = CancelServiceModel();

  @override
  void onInit() {
    // TODO: implement onInit
    var data = Get.arguments;
    findAccountModel = data[0];
  }

  void requestCanncel(var onSuccess) {
    _onLoading(context);
    Map<String, dynamic> body = {
      'subId': findAccountModel.subId,
      'cancelDate': datePicker?.toIso8601String(),
    };
    ApiUtil.getInstance()!.post(
      url: ApiEndPoints.API_REQUEST_CANNCEL
          .replaceAll('subId', findAccountModel.subId.toString()),
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

  void setFromDate(DateTime picked) {
    fromDate.value = "${picked.day}/${picked.month}/${picked.year}";
    update();
  }

  void setToDate(DateTime picked) {
    cancelDate = "${picked.day}/${picked.month}/${picked.year}";
    datePicker = picked;
    update();
  }

  void setDateNow() {
    selectDate = DateTime.now();
  }

  void setCheckAgree(bool value) {
    isCheckAgree = value;
    update();
  }

  bool checkActiveContinue() {
    if (cancelDate.isNotEmpty && isCheckAgree) {
      return true;
    } else {
      return false;
    }
  }
}
