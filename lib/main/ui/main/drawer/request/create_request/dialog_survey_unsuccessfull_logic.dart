import 'package:bitel_ventas/main/networks/api_end_point.dart';
import 'package:bitel_ventas/main/networks/api_util.dart';
import 'package:bitel_ventas/main/utils/values.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/common.dart';

class DialogSurveyUnsuccessfullLogic extends GetxController {
  BuildContext context;
  bool isSelectOffline = true;
  int id;

  DialogSurveyUnsuccessfullLogic({required this.context, required this.id});

  void setSurveyOffline(bool value) {
    isSelectOffline = value;
    update();
  }

  void createSurveyOffline(Function(bool isSuccess) callBack) {
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
}
