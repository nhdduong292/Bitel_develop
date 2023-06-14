import 'dart:async';

import 'package:bitel_ventas/main/networks/api_end_point.dart';
import 'package:bitel_ventas/main/networks/api_util.dart';
import 'package:bitel_ventas/main/networks/model/bill_model.dart';
import 'package:bitel_ventas/main/networks/model/bill_tranfer_service_model.dart';
import 'package:bitel_ventas/main/networks/model/cancel_service_model.dart';
import 'package:bitel_ventas/main/networks/model/find_account_model.dart';
import 'package:bitel_ventas/main/networks/model/package_model.dart';
import 'package:bitel_ventas/main/networks/model/promotion_model.dart';
import 'package:bitel_ventas/main/networks/model/request_detail_model.dart';
import 'package:bitel_ventas/main/networks/response/product_response.dart';
import 'package:bitel_ventas/main/ui/main/drawer/ftth/after_sale/after_sale_search_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/ftth/after_sale/date_cancel_service/date_cancel_service_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/ftth/after_sale/dialog_cancel_service/dialog_cancel_service.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/request_detail/request_detail_logic.dart';
import 'package:bitel_ventas/main/utils/common_widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../../../utils/common.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BillTransferServiceLogic extends GetxController {
  BuildContext context;
  BillTransferServiceLogic({required this.context});

  double balance = 0;
  int requestId = 0;
  int fingerId = 0;
  RequestDetailModel requestDetailModel = RequestDetailModel();
  BillTransferServiceModel billTransferServiceModel =
      BillTransferServiceModel();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    var data = Get.arguments;
    requestDetailModel = data[0];
    requestId = requestDetailModel.id;
    bool isExit = Get.isRegistered<AfterSaleSearchLogic>();
    if (isExit) {
      AfterSaleSearchLogic afterSaleSearchLogic = Get.find();
      fingerId = afterSaleSearchLogic.fingerId;
    }
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getWallet();
    getBillInfor();
  }

  void getWallet() {
    _onLoading(context);
    ApiUtil.getInstance()!.get(
      url: ApiEndPoints.API_WALLET,
      onSuccess: (response) {
        Get.back();
        if (response.isSuccess) {
          balance = response.data['data'] as double;
          update();
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

  void checkBalance(var onSuccess) {
    _onLoading(context);
    ApiUtil.getInstance()!.get(
      url: ApiEndPoints.API_CHECK_BALANCE,
      params: {"amount": billTransferServiceModel.transferFee},
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

  void getBillInfor() {
    _onLoading(context);
    ApiUtil.getInstance()!.get(
      url: ApiEndPoints.API_BILL_INFOR_TRANSFER_SERVICE
          .replaceAll("requestId", requestId.toString()),
      params: {"requestId": requestId},
      onSuccess: (response) {
        Get.back();
        if (response.isSuccess) {
          billTransferServiceModel =
              BillTransferServiceModel.fromJson(response.data['data']);
          update();
        } else {}
      },
      onError: (error) {
        Get.back();
        Common.showMessageError(error: error, context: context);
      },
    );
  }
}
