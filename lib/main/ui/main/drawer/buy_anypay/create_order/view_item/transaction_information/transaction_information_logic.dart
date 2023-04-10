import 'dart:convert';
import 'dart:typed_data';

import 'package:bitel_ventas/main/networks/model/buy_anypay_model.dart';
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

  bool isActiveButton = false;
  String? errorTextAmount;
  CreateOrderLogic createOrderLogic = Get.find();

  TransactionInformationLogic({required this.context});

  double currentAmout = 0.0;

  BuyAnyPayModel buyAnyPayModel = BuyAnyPayModel();
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
    var amount = textAmountController.text.replaceAll(',', '.');
    if (!(double.parse(amount) >= 100 && double.parse(amount) <= 10000)) {
      isActiveButton = false;
      errorTextAmount = AppLocalizations.of(context)!.textTheMinimumIs100;
      update();
      return;
    } else if (textCaptchaController.text.isEmpty) {
      isActiveButton = false;
      update();
      return;
    }
    currentAmout = double.parse(amount);
    isActiveButton = true;
    update();
  }

  void setBuyAnyPayModel() {
    createOrderLogic.buyAnyPayModel = buyAnyPayModel;
  }

  bool validateEmail() {
    if (textEmailController.text.isEmpty) {
      return true;
    }
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
          buyAnyPayModel = BuyAnyPayModel.fromJson(response.data['data']);
          update();
        } else {}
      },
      onError: (error) {
        Get.back();
        Common.showMessageError(error, context);
      },
    );
  }

  void postBuyAnyPay({var isSuccess}) {
    _onLoading(context);
    Map<String, dynamic> body = {
      "saleOrderId": null,
      "code": buyAnyPayModel.code,
      "idNumber": buyAnyPayModel.idNumber,
      "name": buyAnyPayModel.name,
      "amount": currentAmout,
      "discount": buyAnyPayModel.discount,
      "total": null,
      "email": textEmailController.text.trim(),
      "captcha": textCaptchaController.text.trim()
    };
    ApiUtil.getInstance()!.post(
      url: ApiEndPoints.API_POST_BUY_ANYPAY,
      body: body,
      onSuccess: (response) {
        Get.back();
        if (response.isSuccess) {
          buyAnyPayModel = BuyAnyPayModel.fromJson(response.data['data']);
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

  Uint8List convertImageCaptcha() {
    var data = captchaModel.base64Img!.split(',');
    return base64Decode(data[1]);
  }
}
