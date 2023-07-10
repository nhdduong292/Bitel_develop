import 'package:bitel_ventas/main/ui/main/drawer/request/request_detail/request_detail_logic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../../../networks/api_end_point.dart';
import '../../../../../networks/api_util.dart';
import '../../../../../services/connection_service.dart';
import '../../../../../utils/common.dart';
import '../../../../../utils/common_widgets.dart';
import '../../../../../utils/values.dart';
import '../product/product_payment_method_logic.dart';

class ReSignContractLogic extends GetxController {
  late BuildContext context;

  var checkMainContract = true.obs;
  var checkLendingContract = false.obs;
  var checkOption = true.obs;

  String paymentMethod = "";
  bool isVoiceContract = false;
  String voiceContractCallId = "";
  int contractId = 0;

  RequestDetailLogic requestDetailLogic = Get.find();

  ReSignContractLogic({required this.context});

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    contractId = requestDetailLogic.requestModel.id;
    paymentMethod = requestDetailLogic.requestModel.paymentMethod;
    isVoiceContract = requestDetailLogic.requestModel.isVoiceContract;
    voiceContractCallId = requestDetailLogic.requestModel.callId.toString();
    if (isVoiceContract) {
      paymentMethod = PaymentType.BANK_CODE;
    }
    bool isExitChooseProduct = Get.isRegistered<ProductPaymentMethodLogic>();
    if (isExitChooseProduct) {
      ProductPaymentMethodLogic productPaymentMethodLogic = Get.find();
      paymentMethod = productPaymentMethodLogic.isPayBankCode
          ? PaymentType.BANK_CODE
          : PaymentType.CASH;
      isVoiceContract = productPaymentMethodLogic.checkVoiceContract.value;
      voiceContractCallId =
          productPaymentMethodLogic.voiceContractTextController.text.trim();
    }
  }

  void signContract(String type, Function(bool) isSuccess) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    try {
      _onLoading(context);
      Map<String, dynamic> body = {
        "paymentMethod": paymentMethod,
        "isVoiceContract": isVoiceContract,
        "voiceContractCallId": voiceContractCallId
      };
      Map<String, dynamic> params = {"type": type};
      ApiUtil.getInstance()!.put(
        url: ApiEndPoints.API_SIGN_CONTRACT
            .replaceAll('id', contractId.toString()),
        body: body,
        params: params,
        onSuccess: (response) {
          Get.back();
          if (response.isSuccess) {
            isSuccess.call(true);
          } else {
            isSuccess.call(false);
            print("error: ${response.status}");
          }
        },
        onError: (error) {
          Get.back();
          isSuccess.call(false);
          Common.showMessageError(error: error, context: context);
        },
      );
    } catch (e) {
      Get.back();
      Common.showToastCenter(e.toString(), context);
    }
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
