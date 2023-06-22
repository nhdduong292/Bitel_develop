import 'package:bitel_ventas/main/networks/api_end_point.dart';
import 'package:bitel_ventas/main/networks/api_util.dart';
import 'package:bitel_ventas/main/ui/main/drawer/ftth/after_sale/transfer_service/create_transfer_service_logic.dart';
import 'package:bitel_ventas/main/utils/values.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../services/connection_service.dart';
import '../../../../../utils/common.dart';

class DialogSurveySuccessfulLogic extends GetxController {
  BuildContext context;
  bool isSelectOffline = false;
  int id;
  String type = '';

  DialogSurveySuccessfulLogic({required this.context, required this.id});

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getType();
  }

  void getType() {
    bool isExit = Get.isRegistered<CreateTransferServiceLogic>();
    if (isExit) {
      type = AfterSaleStatus.TRANSFER_SERVICE;
    }
  }

  void setSurveyOffline(bool value) {
    isSelectOffline = value;
    update();
  }

  void createSurveyOnline(Function(bool isSuccess) callBack) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    ApiUtil.getInstance()!.get(
        url:
            "${ApiEndPoints.API_SURVEY}/${id}${ApiEndPoints.API_SURVEY_ONLINE}",
        onSuccess: (response) {
          if (response.isSuccess) {
            print("success");
            callBack.call(true);
          } else {
            print("error: ${response.status}");
            callBack.call(false);
          }
        },
        onError: (error) {
          callBack.call(false);
          Common.showMessageError(error: error, context: context);
        });
  }

  void lockTransferService(Function(bool isSuccess) callBack) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    ApiUtil.getInstance()!.post(
        url: ApiEndPoints.API_LOCK_TRANSFER_SERVICE
            .replaceAll("requestId", id.toString()),
        params: {"requestId": id},
        onSuccess: (response) {
          if (response.isSuccess) {
            print("success");
            callBack.call(true);
          } else {
            print("error: ${response.status}");
            callBack.call(false);
          }
        },
        onError: (error) {
          callBack.call(false);
          Common.showMessageError(error: error, context: context);
        });
  }

  void createSurveyOffline(Function(bool isSuccess) callBack) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    Map<String, dynamic> body = {
      "status": RequestStatus.CREATE_REQUEST,
      "reasonId": "",
      "note": ""
    };
    ApiUtil.getInstance()!.put(
        url:
            "${ApiEndPoints.API_REQUEST_DETAIL}/${id}${ApiEndPoints.API_CHANGE_STATUS_REQUEST}",
        body: body,
        onSuccess: (response) {
          if (response.isSuccess) {
            print("success");
            // requestModel = RequestModel.fromJson(response.data);
            callBack.call(true);
          } else {
            print("error: ${response.status}");
            callBack.call(false);
          }
        },
        onError: (error) {
          callBack.call(false);
          Common.showMessageError(error: error, context: context);
        });
  }

  void createSurveyOfflineTransfer(Function(bool isSuccess) callBack) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    ApiUtil.getInstance()!.post(
        url: ApiEndPoints.API_SURVEY_OFFLINE_TRANSFER
            .replaceAll("requestId", id.toString()),
        params: {"requestId": id},
        onSuccess: (response) {
          if (response.isSuccess) {
            print("success");
            // requestModel = RequestModel.fromJson(response.data);
            callBack.call(true);
          } else {
            print("error: ${response.status}");
            callBack.call(false);
          }
        },
        onError: (error) {
          callBack.call(false);
          Common.showMessageError(error: error, context: context);
        });
  }
}
