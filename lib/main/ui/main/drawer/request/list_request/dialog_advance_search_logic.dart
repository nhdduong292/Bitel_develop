import 'dart:math';

import 'package:bitel_ventas/main/networks/api_end_point.dart';
import 'package:bitel_ventas/main/networks/api_util.dart';
import 'package:bitel_ventas/main/networks/model/address_model.dart';
import 'package:bitel_ventas/main/networks/request/search_request.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/list_request/list_request_logic.dart';
import 'package:bitel_ventas/main/utils/common.dart';
import 'package:bitel_ventas/main/utils/values.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../../../services/connection_service.dart';

class DialogAdvanceSearchLogic extends GetxController {
  BuildContext context;

  var from = "".obs;
  var to = "".obs;
  DateTime selectDate = DateTime.now();
  List<String> listReason = ["HN", "HCM", "PQ"];
  List<String> listService = ["FTTH", "OFFICE_WAN", "LEASED_LINE"];
  List<AddressModel> listProvince = [];
  SearchRequest searchRequest;
  TextEditingController controllerCode = TextEditingController();
  TextEditingController controllerStaffCode = TextEditingController();
  TextEditingController controllerProvince = TextEditingController();
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();
  ListRequestLogic listRequestLogic = Get.find();
  String currentActionCode = '';

  DialogAdvanceSearchLogic(this.context, this.searchRequest) {
    if (searchRequest.fromDate.isNotEmpty) {
      fromDate = DateTime.parse(searchRequest.fromDate);
      from.value = "${fromDate.day}/${fromDate.month}";
    }
    if (searchRequest.toDate.isNotEmpty) {
      toDate = DateTime.parse(searchRequest.toDate);
      to.value = "${toDate.day}/${toDate.month}";
    }
    controllerCode.text = searchRequest.code;
    controllerStaffCode.text = searchRequest.staffCode;
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    try {
      setToDate(DateTime.parse(listRequestLogic.currentToDate));
      setFromDate(DateTime.parse(listRequestLogic.currentFromDate));
    } catch (e) {
      print(e.toString());
    }
  }

  void setProvince(AddressModel value) {
    searchRequest.province = value.areaCode;
    controllerProvince.text = value.name;
    update();
  }

  void setStaffCode(String value) {
    searchRequest.staffCode = value;
    update();
  }

  void setToDate(DateTime picked) {
    // print("Date: "+picked.toString());
    toDate = picked;
    to.value = "${picked.day}/${picked.month}/${picked.year}";
    searchRequest.toDate = picked.toIso8601String();
    update();
  }

  void setFromDate(DateTime picked) {
    // print("Date: "+picked.toString());
    // print("Date: "+picked.toIso8601String());
    fromDate = picked;
    from.value = "${picked.day}/${picked.month}/${picked.year}";
    searchRequest.fromDate = picked.toIso8601String();
    // DateTime pi = DateTime.parse(picked.toIso8601String());
    update();
  }

  void setStatus(String value) {
    searchRequest.status = value;
    update();
  }

  void setActionCode(String value) {
    currentActionCode = value;
    if (value == AppLocalizations.of(context)!.textNewConnect) {
      searchRequest.actionCode = ActionCode.NEW_CONNECT;
    } else if (value == AppLocalizations.of(context)!.textCancelRequest) {
      searchRequest.actionCode = ActionCode.CANCEL_CONTRACT;
    } else {
      searchRequest.actionCode = '';
    }
    update();
  }

  void setService(String value) {
    searchRequest.service = value;
    update();
  }

  void setRequestCode(String value) {
    searchRequest.code = value;
    update();
  }

  bool checkValidate(BuildContext context) {
    // if(currentService.isEmpty){
    //   return false;
    // }
    // if(currentService.isEmpty){
    //   return false;
    // }
    int timeFrom = fromDate.millisecondsSinceEpoch;
    int timeTo = toDate.millisecondsSinceEpoch;
    int result = timeTo - timeFrom;
    print("time: $result");
    if (result < 0) {
      Common.showToastCenter(
          AppLocalizations.of(context)!.textValidateFromTo, context);
      return false;
    }
    return true;
  }

  void getListProvince(Function(bool isSuccess) function) async {
    bool isConnect =
        await ConnectionService.getInstance()?.checkConnect(context) ?? true;
    if (!isConnect) {
      return;
    }
    ApiUtil.getInstance()!.get(
        url: ApiEndPoints.API_PROVINCES,
        onSuccess: (response) {
          if (response.isSuccess) {
            print("success");
            listProvince = (response.data['data'] as List)
                .map((postJson) => AddressModel.fromJson(postJson))
                .toList();
            function.call(true);
            update();
          } else {
            print("error: ${response.status}");
            function.call(false);
          }
        },
        onError: (error) {
          function.call(false);
          Common.showMessageError(error: error, context: context);
        });
  }
}
