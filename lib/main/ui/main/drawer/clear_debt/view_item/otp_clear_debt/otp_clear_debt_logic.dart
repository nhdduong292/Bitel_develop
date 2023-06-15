import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../networks/api_end_point.dart';
import '../../../../../../networks/api_util.dart';
import '../../../../../../networks/model/clear_debt_model.dart';
import '../../../../../../services/connection_service.dart';
import '../../../../../../utils/common.dart';
import '../../../../../../utils/common_widgets.dart';
import '../../clear_debt_logic.dart';

class OTPClearDebtLogic extends GetxController {
  BuildContext context;
  var countDown = 120.obs;
  bool isActiveButton = false;
  ClearDebtModel clearDebtModel = ClearDebtModel();
  double totalService = 0;
  ClearDebtLogic clearDebtLogic = Get.find();
  String otp = '';
  var isClickResendOTP = false.obs;

  OTPClearDebtLogic({required this.context});
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    startTimer();
    clearDebtModel = clearDebtLogic.clearDebtModel;
    totalService = clearDebtLogic.totalService;
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

  void resendOTP(var onSuccess) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    _onLoading(context);
    ApiUtil.getInstance()!.post(
      url: ApiEndPoints.API_RESEND_OTP,
      onSuccess: (response) {
        Get.back();
        if (response.isSuccess) {
          onSuccess(true);
        } else {
          onSuccess(false);
        }
      },
      onError: (error) {
        Get.back();
        Common.showMessageError(error: error, context: context);
      },
    );
  }

  void onPayment({required var isSuccess}) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    _onLoading(context);
    ApiUtil.getInstance()!.post(
      url: ApiEndPoints.API_PAYMENT,
      body: {
        "isdn": clearDebtModel.isdn,
        "serviceType": clearDebtModel.serviceType,
        "amount": totalService,
        'opt': otp
      },
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
