import 'package:bitel_ventas/main/networks/model/find_account_model.dart';
import 'package:bitel_ventas/main/networks/model/product_change_plan_model.dart';
import 'package:bitel_ventas/main/networks/model/product_model.dart';
import 'package:bitel_ventas/main/networks/model/reasons_cancel_service_model.dart';
import 'package:bitel_ventas/main/ui/main/drawer/ftth/after_sale/change_plan/choose/choose_change_plan_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../networks/api_end_point.dart';
import '../../../../../../../networks/api_util.dart';
import '../../../../../../../networks/model/check_payment_change_plan_model.dart';
import '../../../../../../../networks/model/customer_model.dart';
import '../../../../../../../services/connection_service.dart';
import '../../../../../../../utils/common.dart';
import '../../../../../../../utils/common_widgets.dart';

class InforChangePlanLogic extends GetxController {
  BuildContext context;

  InforChangePlanLogic({required this.context});

  CheckPaymentChangePlanModel checkPaymentChangePlanModel =
      CheckPaymentChangePlanModel();
  ChooseChangePlanLogic chooseChangePlanLogic = Get.find();
  ProductModel currentPlan = ProductModel();
  ProductModel newPlan = ProductModel();
  CustomerModel customerModel = CustomerModel();
  int subId = 0;
  var balance = (0.0).obs; //
  int fingerId = 0;
  List<int> listIdPromotion = [];

  bool isPayBankCode = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    checkPaymentChangePlanModel =
        chooseChangePlanLogic.checkPaymentChangePlanModel;
    currentPlan = chooseChangePlanLogic.productChangePlanModel.currentPlan;
    newPlan = chooseChangePlanLogic.productChangePlanModel
        .newPlan[chooseChangePlanLogic.valueProduct.value];
    subId = chooseChangePlanLogic.subId;
    fingerId = chooseChangePlanLogic.fingerId;
    listIdPromotion = chooseChangePlanLogic.listIdPromotion;
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getWallet(context);
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

  void getWallet(BuildContext context) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    _onLoading(context);
    ApiUtil.getInstance()!.get(
      url: ApiEndPoints.API_WALLET,
      onSuccess: (response) {
        Get.back();
        if (response.isSuccess) {
          balance.value = response.data['data'] as double;
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

  void checkBalance(var onSuccess) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    _onLoading(context);
    ApiUtil.getInstance()!.get(
      url: ApiEndPoints.API_CHECK_BALANCE,
      params: {"amount": checkPaymentChangePlanModel.totalAmount},
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
        try {
          String errorCode = error.response!.data['errorCode'];
          if (errorCode == 'E028') {
            onSuccess(false);
          }
          // ignore: empty_catches
        } catch (e) {}
      },
    );
  }

  void getCustomer(var onSuccess) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    _onLoading(context);
    ApiUtil.getInstance()!.get(
      url: ApiEndPoints.API_GET_CUSTOMER_INFO,
      params: {"subId": subId},
      onSuccess: (response) {
        Get.back();
        if (response.isSuccess) {
          customerModel = CustomerModel.fromJson(response.data['data']);
          onSuccess(true);
        } else {
          onSuccess(false);
          print("error: ${response.status}");
        }
      },
      onError: (error) {
        Get.back();
        onSuccess(false);
        Common.showMessageError(error: error, context: context);
      },
    );
  }

  void checkBankCode(bool value) {
    // if (checkVoiceContract.value && !value) {
    //   Common.showToastCenter(
    //       AppLocalizations.of(context)!
    //           .textTypeOfVoiceContractThatOnlyAllowsBankCode,
    //       context);
    // } else {
    //   isPayBankCode = value;
    //   update();
    // }
    isPayBankCode = value;
    update();
  }
}
