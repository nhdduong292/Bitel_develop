import 'dart:async';

import 'package:bitel_ventas/main/networks/api_end_point.dart';
import 'package:bitel_ventas/main/networks/api_util.dart';
import 'package:bitel_ventas/main/networks/model/reason_model.dart';
import 'package:bitel_ventas/main/networks/model/staff_model.dart';
import 'package:bitel_ventas/main/utils/common.dart';
import 'package:bitel_ventas/main/utils/values.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../services/connection_service.dart';
import '../../../../../utils/common_widgets.dart';

class DialogTransferRequestLogic extends GetxController {
  BuildContext context;
  int currentReason = 0;
  String currentStaffCode = "";
  List<ReasonModel> listReason = [];
  bool isLoading = false;
  List<StaffModel> listStaff = [];
  TextEditingController staffTextController = TextEditingController();

  DialogTransferRequestLogic({required this.context});

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // getListReason();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getListReason();
  }

  void setStaffCode(String value) {
    currentStaffCode = value;
    update();
  }

  void getListReason() async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    _onLoading(context);
    Map<String, dynamic> params = {
      "type": Reason.REASON_REQUEST_TRANSFER,
    };
    ApiUtil.getInstance()!.get(
      url: "${ApiEndPoints.API_REASONS}",
      params: params,
      onSuccess: (response) {
        Get.back();
        if (response.isSuccess) {
          List<ReasonModel> list = (response.data['data'] as List)
              .map((postJson) => ReasonModel.fromJson(postJson))
              .toList();
          if (list.isNotEmpty) {
            listReason.addAll(list);
            if (listReason.isNotEmpty) {
              currentReason = listReason[0].id ?? 0;
            }
            update();
          }
        } else {}
      },
      onError: (error) {
        Common.showMessageError(error: error, context: context);
      },
    );
  }

  bool checkValidate(BuildContext context) {
    if (currentStaffCode.isEmpty || currentReason == 0) {
      Common.showToastCenter(
          AppLocalizations.of(context)!.textInputInfo, context);
      return true;
    }
    return false;
  }

  void transferRequest(int id, String staffCode, BuildContext context,
      Function(bool isSuccess) callBack) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    // Future.delayed(Duration(seconds: 1));
    Map<String, dynamic> body = {
      "staffCode": staffCode,
      "reason": currentReason
    };
    print("staffCode: $staffCode");
    ApiUtil.getInstance()!.put(
        url:
            "${ApiEndPoints.API_REQUEST_DETAIL}/$id${ApiEndPoints.API_TRANSFER_REQUEST}",
        body: body,
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
          Get.back();
          Common.showMessageError(error: error, context: context);
          // callBack.call(false);
        });
  }

  Future<List<StaffModel>> getStaffs(String query) async {
    Completer<List<StaffModel>> completer = Completer();
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      FocusScope.of(context).requestFocus(FocusNode());
      return completer.future;
    }
    ApiUtil.getInstance()!.get(
        url: ApiEndPoints.API_LIST_STAFF,
        params: {'key': query},
        onSuccess: (response) {
          if (response.isSuccess) {
            print("success");
            listStaff = (response.data['data'] as List)
                .map((postJson) => StaffModel.fromJson(postJson))
                .toList();
            completer.complete(listStaff);
          } else {
            print("error: ${response.status}");
            completer.complete([]);
          }
        },
        onError: (error) {
          Get.back();
          Common.showMessageError(error: error, context: context);
          completer.complete([]);
          // callBack.call(false);
        });
    return completer.future;
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
