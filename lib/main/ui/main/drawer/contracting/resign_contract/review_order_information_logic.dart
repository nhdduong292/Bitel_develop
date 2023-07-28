import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:bitel_ventas/main/networks/api_end_point.dart';
import 'package:bitel_ventas/main/networks/api_util.dart';
import 'package:bitel_ventas/main/networks/model/bill_model.dart';
import 'package:bitel_ventas/main/networks/model/package_model.dart';
import 'package:bitel_ventas/main/networks/model/plan_ott_model.dart';
import 'package:bitel_ventas/main/networks/model/promotion_model.dart';
import 'package:bitel_ventas/main/networks/model/request_detail_model.dart';
import 'package:bitel_ventas/main/networks/model/request_ott_service_model.dart';
import 'package:bitel_ventas/main/networks/response/product_response.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/request_detail/request_detail_logic.dart';
import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:bitel_ventas/main/utils/values.dart';
import 'package:dio/dio.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../../networks/model/customer_model.dart';
import '../../../../../networks/model/method_model.dart';
import '../../../../../networks/model/plan_reason_model.dart';
import '../../../../../networks/model/product_model.dart';
import '../../../../../networks/model/sub_ott_model.dart';
import '../../../../../services/connection_service.dart';
import '../../../../../utils/common.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../utilitis/info_bussiness.dart';

class ReviewOrderInformationLogic extends GetxController {
  BuildContext context;
  bool isLoadingWallet = true;
  bool isLoadingBill = true;

  RequestDetailModel requestModel = RequestDetailModel();

  bool isPayBankCode = false;
  bool isPayCash = false;

  int contractId = 0;

  ReviewOrderInformationLogic({required this.context});

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    bool isExit = Get.isRegistered<RequestDetailLogic>();
    if (isExit) {
      RequestDetailLogic requestDetailLogic = Get.find();
      contractId = requestDetailLogic.requestModel.contractModel.contractId;
    }
  }

  var balance = (0.0).obs; // so du trong vi
  var totalPayment = 0; // tong tien phai thanh toan

  CustomerModel customer = CustomerModel();
  List<int> listIdPromotion = [];
  BillModel billModel = BillModel();

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    checkLoadingBill();
    getWallet(context);
    getInvoiceInfo(context);
  }

  void checkLoadingBill() {
    if (!isLoadingBill && !isLoadingWallet) {
      Get.back();
    } else if (isLoadingBill && isLoadingWallet) {
      _onLoading(context);
    }
  }

  void getInvoiceInfo(BuildContext context) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      isLoadingBill = false;
      checkLoadingBill();
      return;
    }
    isLoadingBill = true;
    ApiUtil.getInstance()!.get(
      url: ApiEndPoints.API_GET_INVOICE_INFO
          .replaceAll("id", contractId.toString()),
      onSuccess: (response) {
        isLoadingBill = false;
        checkLoadingBill();
        if (response.isSuccess) {
          billModel = BillModel.fromJson(response.data['data']);
          update();
        } else {
          print("error: ${response.status}");
        }
      },
      onError: (error) {
        isLoadingBill = false;
        checkLoadingBill();
        Common.showMessageError(error: error, context: context);
      },
    );
  }

  void getWallet(BuildContext context) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      isLoadingWallet = false;
      checkLoadingBill();
      return;
    }
    isLoadingWallet = true;
    ApiUtil.getInstance()!.get(
      url: ApiEndPoints.API_WALLET,
      onSuccess: (response) {
        isLoadingWallet = false;
        checkLoadingBill();
        if (response.isSuccess) {
          balance.value = response.data['data'] as double;
        } else {
          print("error: ${response.status}");
        }
      },
      onError: (error) {
        isLoadingWallet = false;
        checkLoadingBill();
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

  void checkBalance(var onSuccess) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    _onLoading(context);
    ApiUtil.getInstance()!.get(
      url: ApiEndPoints.API_CHECK_BALANCE,
      params: {"amount": billModel.total},
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

  void checkBankCode(bool value) {
    if (value) {
      isPayBankCode = true;
      isPayCash = false;
    } else {
      isPayCash = true;
      isPayBankCode = false;
    }
    update();
  }

  bool validatePayment() {
    if (isPayBankCode || isPayCash) {
      return true;
    }
    Common.showToastCenter(
        AppLocalizations.of(context)!.textPaymentIsRequired, context);
    return false;
  }
}
