import 'package:bitel_ventas/main/networks/model/cancel_service_model.dart';
import 'package:bitel_ventas/main/networks/model/find_account_model.dart';
import 'package:bitel_ventas/main/ui/main/drawer/ftth/after_sale/after_sale_search_logic.dart';
import 'package:bitel_ventas/main/utils/common.dart';
import 'package:bitel_ventas/main/utils/values.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../networks/api_end_point.dart';
import '../../../../../../networks/api_util.dart';
import '../../../../../../networks/model/check_debt_model.dart';
import '../../../../../../router/route_config.dart';
import '../../../../../../services/connection_service.dart';
import '../../../../../../utils/common_widgets.dart';
import 'choose_service_page.dart';

class ChooseServiceLogic extends GetxController {
  AfterSaleSearchLogic afterSaleSearchLogic = Get.find();
  bool isActive = true;
  List<FindAccountModel> listAccount = [];
  var valueService = (-1).obs;
  CancelServiceModel cancelServiceModel = CancelServiceModel();
  CheckDebtModel checkDebtModel = CheckDebtModel();

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

  void checkDebtWO(var onSuccess) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    _onLoading(context);
    Map<String, dynamic> body = {
      'subId': listAccount[valueService.value].subId,
    };
    ApiUtil.getInstance()!.get(
      url: ApiEndPoints.API_CHECK_DEBT_WO,
      params: body,
      onSuccess: (response) {
        Get.back();
        if (response.isSuccess) {
          checkDebtModel = CheckDebtModel.fromJson(response.data['data']);
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

  void checkOldRequest(String type, var onSuccess) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    _onLoading(context);
    String url = "";
    if (type == AfterSaleStatus.CANCEL_SERVICE) {
      url = ApiEndPoints.API_CHECK_OLD_CANCEL_SERVICE;
    } else if (type == AfterSaleStatus.CHANGE_PLAN) {
      url = ApiEndPoints.API_CHECK_OLD_REQUEST_CHANGE_PLAN;
    } else if (type == AfterSaleStatus.TRANSFER_SERVICE) {
      url = ApiEndPoints.API_CHECK_OLD_REQUEST_TRANSFER;
    }
    ApiUtil.getInstance()!.get(
      url: url.replaceAll(
          'subId', listAccount[valueService.value].subId.toString()),
      params: {"subId": listAccount[valueService.value].subId},
      onSuccess: (response) {
        Get.back();
        if (response.isSuccess) {
          onSuccess(true);
        } else {
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

  void requestCanncel(var onSuccess) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
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

  void onCheckDebtWO() {
    if (checkDebtModel.isDebt) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return NotiCancelDialog(
              model: checkDebtModel,
              isDebt: true,
              onOk: () {
                if (checkDebtModel.isPendingWo) {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return NotiCancelDialog(
                          model: checkDebtModel,
                          isDebt: false,
                          onOk: () {
                            Get.toNamed(RouteConfig.dateCancelService,
                                arguments: [listAccount[valueService.value]]);
                          },
                        );
                      });
                } else {
                  Get.toNamed(RouteConfig.dateCancelService,
                      arguments: [listAccount[valueService.value]]);
                }
              },
            );
          });
    } else {
      if (checkDebtModel.isPendingWo) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return NotiCancelDialog(
                model: checkDebtModel,
                isDebt: false,
                onOk: () {
                  Get.toNamed(RouteConfig.dateCancelService,
                      arguments: [listAccount[valueService.value]]);
                },
              );
            });
      } else {
        Get.toNamed(RouteConfig.dateCancelService,
            arguments: [listAccount[valueService.value]]);
      }
    }
  }
}
