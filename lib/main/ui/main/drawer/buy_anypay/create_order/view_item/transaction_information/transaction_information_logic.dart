import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:bitel_ventas/main/networks/model/buy_anypay_comfirm_model.dart';
import 'package:bitel_ventas/main/networks/model/buy_anypay_create_model.dart';
import 'package:bitel_ventas/main/networks/model/captcha_model.dart';
import 'package:bitel_ventas/main/ui/main/drawer/buy_anypay/create_order/create_order_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/clear_debt/clear_debt_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../../networks/api_end_point.dart';
import '../../../../../../../networks/api_util.dart';
import '../../../../../../../utils/common.dart';
import '../../../../../../../utils/common_widgets.dart';

class TransactionInformationLogic extends GetxController {
  BuildContext context;
  final FocusScopeNode focusScopeNode = FocusScopeNode();

  TextEditingController textAmountController = TextEditingController();
  TextEditingController textEmailController = TextEditingController();
  TextEditingController textCaptchaController = TextEditingController();

  FocusNode focusCaptcha = FocusNode();

  bool isActiveButton = false;
  String? errorTextAmount;
  String? errorTextCaptcha;
  CreateOrderLogic createOrderLogic = Get.find();

  TransactionInformationLogic({required this.context});

  double currentAmout = 0.0;

  BuyAnyPayGeneralModel buyAnyPayComfirmModel = BuyAnyPayGeneralModel();
  BuyAnyPayCreateModel buyAnyPayCreateModel = BuyAnyPayCreateModel();
  CaptchaModel captchaModel = CaptchaModel();

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getBuyAnyPay();
    getCaptcha();
  }

  void checkValidate() {
    errorTextAmount = null;
    if (textAmountController.text.isEmpty) {
      isActiveButton = false;
      update();
      return;
    }
    var amount = textAmountController.text;
    if (!(double.parse(amount) >= buyAnyPayComfirmModel.amountMin &&
        double.parse(amount) <= buyAnyPayComfirmModel.amountMax)) {
      isActiveButton = false;
      errorTextAmount = AppLocalizations.of(context)!.textTheMinimumIs100(
          buyAnyPayComfirmModel.amountMax.toInt(),
          buyAnyPayComfirmModel.amountMin.toInt());
      update();
      return;
    } else if (textCaptchaController.text.isEmpty) {
      isActiveButton = false;
      update();
      return;
    } else if (textEmailController.text.isEmpty) {
      isActiveButton = false;
      update();
      return;
    }
    currentAmout = double.parse(amount);
    isActiveButton = true;
    update();
  }

  void setBuyAnyPayModel() {
    createOrderLogic.buyAnyPayCreateModel = buyAnyPayCreateModel;
  }

  bool validateEmail() {
    if (!Common.validateEmail(textEmailController.text)) {
      Common.showToastCenter(AppLocalizations.of(context)!.textValidateEmail);
      return false;
    }
    return true;
  }

  void getBuyAnyPay() {
    _onLoading(context);
    ApiUtil.getInstance()!.get(
      url: ApiEndPoints.API_GET_BUY_ANYPAY,
      onSuccess: (response) {
        Get.back();
        if (response.isSuccess) {
          buyAnyPayComfirmModel =
              BuyAnyPayGeneralModel.fromJson(response.data['data']);
          update();
        } else {}
      },
      onError: (error) {
        Get.back();
        Common.showMessageError(error: error, context: context);
      },
    );
  }

  void postBuyAnyPayComfirm({var isSuccess}) {
    _onLoading(context);
    Map<String, dynamic> body = {
      "idType": buyAnyPayComfirmModel.idType,
      "idNumber": buyAnyPayComfirmModel.idNumber,
      "amount": int.parse(textAmountController.text.trim()),
      "email": textEmailController.text.trim(),
    };
    createOrderLogic.bodyRequestBuyAnyPay = body;
    ApiUtil.getInstance()!.post(
      url: ApiEndPoints.API_CONFIRM_POST_BUY_ANYPAY,
      body: body,
      onSuccess: (response) {
        Get.back();
        if (response.isSuccess) {
          buyAnyPayCreateModel =
              BuyAnyPayCreateModel.fromJson(response.data['data']);
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

  void getCaptcha() {
    ApiUtil.getInstance()!.get(
      url: ApiEndPoints.API_GET_CAPTCHA,
      params: {'action': 'BUY_ANYPAY'},
      onSuccess: (response) {
        if (response.isSuccess) {
          captchaModel = CaptchaModel.fromJson(response.data['data']);
          update();
        } else {}
      },
      onError: (error) {
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

  Uint8List convertImageCaptcha() {
    try {
      var data = captchaModel.base64Img!.split(',');
      return base64Decode(data[1]);
    } catch (e) {
      return base64Decode(captchaModel.base64Img!);
    }
  }
}
