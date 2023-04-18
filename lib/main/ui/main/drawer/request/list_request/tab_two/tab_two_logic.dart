import 'package:bitel_ventas/main/networks/api_end_point.dart';
import 'package:bitel_ventas/main/networks/api_util.dart';
import 'package:bitel_ventas/main/networks/model/request_model.dart';
import 'package:bitel_ventas/main/networks/response/list_request_response.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/list_request/list_request_logic.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../utils/common.dart';

class TabTwoLogic extends GetxController {
  ListRequestLogic listRequestLogic = Get.find();
  List<RequestModel> listRequest = [];
  bool isLoading = false;
  String status;
  BuildContext context;

  TabTwoLogic(this.status, this.context);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getListRequest(status);
  }

  void getListRequest(String status) async {
    isLoading = true;
    update();
    Future.delayed(Duration(seconds: 1));
    Map<String, dynamic> params = {
      "service": listRequestLogic.searchRequest.service,
      "code": listRequestLogic.searchRequest.code,
      "status": status,
      "province": listRequestLogic.searchRequest.province,
      "staffCode": listRequestLogic.searchRequest.staffCode,
      "fromDate": listRequestLogic.searchRequest.fromDate,
      "toDate": listRequestLogic.searchRequest.toDate,
      "key": "",
      "page": "0",
      "pageSize": "10",
      "sort": ""
    };
    ApiUtil.getInstance()!.get(
        url: ApiEndPoints.API_LIST_REQUEST,
        params: params,
        onSuccess: (response) {
          if (response.isSuccess) {
            print("success :");
            listRequest.clear();
            ListRequestResponse listRequestResponse =
                ListRequestResponse.fromJson(response.data['data']);
            // listRequest.addAll(listRequestResponse.list);
          } else {
            print("error: ${response.status}");
          }
          isLoading = false;
          update();
        },
        onError: (error) {
          isLoading = false;
          update();
          Common.showMessageError(error: error, context: context);
        });
  }
}
