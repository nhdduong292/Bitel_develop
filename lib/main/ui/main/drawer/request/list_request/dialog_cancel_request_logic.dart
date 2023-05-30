import 'package:bitel_ventas/main/networks/api_end_point.dart';
import 'package:bitel_ventas/main/networks/api_util.dart';
import 'package:bitel_ventas/main/networks/model/reason_model.dart';
import 'package:bitel_ventas/main/utils/common.dart';
import 'package:bitel_ventas/main/utils/values.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../utils/common_widgets.dart';

class DialogCancelRequestLogic extends GetxController {
  BuildContext context;
  int currentReason = 0;
  String currentNote = "";
  List<ReasonModel> listReason = [];
  bool isLoading = false;

  DialogCancelRequestLogic({required this.context});

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getListReason();
  }

  void setNote(String value) {
    currentNote = value;
    update();
  }

  void getListReason() {
    _onLoading(context);
    Map<String, dynamic> params = {
      "type": Reason.REASON_REQUEST_CANCEL,
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
        Get.back();
        Common.showMessageError(error: error, context: context);
      },
    );
  }

  bool checkValidate(BuildContext context) {
    if (currentReason == 0 || currentNote.isEmpty) {
      // Common.showToastCenter(AppLocalizations.of(context)!.textInputInfo);
      return true;
    }
    return false;
  }

  void changeStatusRequest(
      int id, String note, Function(bool isSuccess) callBack) async {
    Future.delayed(Duration(seconds: 1));
    Map<String, dynamic> body = {
      "status": RequestStatus.CANCEL,
      "reasonId": currentReason,
      "note": note
    };
    print("note: $note");
    ApiUtil.getInstance()!.put(
        url:
            "${ApiEndPoints.API_REQUEST_DETAIL}/$id${ApiEndPoints.API_CHANGE_STATUS_REQUEST}",
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
          Get.back();
          Common.showMessageError(error: error, context: context);
        });
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
