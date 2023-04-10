import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../networks/api_end_point.dart';
import '../../../../../../networks/api_util.dart';
import '../../../../../../networks/model/clear_debt_model.dart';
import '../../../../../../utils/common.dart';
import '../../../../../../utils/common_widgets.dart';
import '../../clear_debt_logic.dart';

class OTPClearDebtLogic extends GetxController {
  BuildContext context;
  var countDown = 120.obs;
  bool isActiveButton = false;
  List<ClearDebtModel> listSelectClearDebt = [];
  ClearDebtLogic clearDebtLogic = Get.find();
  String otp = '';

  OTPClearDebtLogic({required this.context});
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    startTimer();
    listSelectClearDebt = clearDebtLogic.listSelectClearDebt;
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

  void putClearDebt({required var isSuccess}) {
    _onLoading(context);
    ApiUtil.getInstance()!.put(
      url: ApiEndPoints.API_PUT_CLEAR_DEBT,
      body: {'lst': json.decode(jsonEncode(listSelectClearDebt)), 'opt': otp},
      onSuccess: (response) {
        Get.back();
        if (response.isSuccess) {
          isSuccess(true);
        } else {
          isSuccess(false);
        }
      },
      onError: (error) {
        Get.back();
        isSuccess(false);
        Common.showMessageError(error, context);
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
