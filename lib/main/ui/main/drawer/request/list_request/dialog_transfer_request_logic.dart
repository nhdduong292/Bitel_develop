import 'dart:async';

import 'package:bitel_ventas/main/networks/api_end_point.dart';
import 'package:bitel_ventas/main/networks/api_util.dart';
import 'package:bitel_ventas/main/networks/model/reason_model.dart';
import 'package:bitel_ventas/main/networks/model/staff_model.dart';
import 'package:bitel_ventas/main/utils/common.dart';
import 'package:bitel_ventas/main/utils/values.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    getListReason();
  }

  void setStaffCode(String value) {
    currentStaffCode = value;
    update();
  }

  void getListReason() {
    Map<String, dynamic> params = {
      "type": Reason.REASON_REQUEST_TRANSFER,
    };
    ApiUtil.getInstance()!.get(
      url: "${ApiEndPoints.API_REASONS}",
      params: params,
      onSuccess: (response) {
        if (response.isSuccess) {
          List<ReasonModel> list = (response.data['data'] as List)
              .map((postJson) => ReasonModel.fromJson(postJson))
              .toList();
          if (list.isNotEmpty) {
            listReason.addAll(list);
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
      Common.showToastCenter(AppLocalizations.of(context)!.textInputInfo);
      return true;
    }
    return false;
  }

  void transferRequest(int id, String staffCode, BuildContext context,
      Function(bool isSuccess) callBack) {
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

  Future<List<StaffModel>> getStaffs(String query) {
    Completer<List<StaffModel>> completer = Completer();
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
}
