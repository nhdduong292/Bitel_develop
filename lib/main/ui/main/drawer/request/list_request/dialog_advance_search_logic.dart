import 'dart:math';

import 'package:bitel_ventas/main/networks/api_end_point.dart';
import 'package:bitel_ventas/main/networks/api_util.dart';
import 'package:bitel_ventas/main/networks/model/address_model.dart';
import 'package:bitel_ventas/main/networks/request/search_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogAdvanceSearchLogic extends GetxController {
  var fromDate = "".obs;
  var toDate = "".obs;
  DateTime selectDate = DateTime.now();
  List<String> listReason = ["HN", "HCM", "PQ"];
  List<String> listService = ["FTTH", "OFFICE_WAN", "LEASED_LINE"];
  List<AddressModel> listProvince = [];
  SearchRequest searchRequest;
  TextEditingController controllerCode = TextEditingController();
  TextEditingController controllerStaffCode = TextEditingController();


  DialogAdvanceSearchLogic(this.searchRequest){
    if(searchRequest.fromDate.isNotEmpty) {
      DateTime dateFrom = DateTime.parse(searchRequest.fromDate);
      fromDate.value = "${dateFrom.day}/${dateFrom.month}";
    }
    if(searchRequest.toDate.isNotEmpty) {
      DateTime dateTo = DateTime.parse(searchRequest.toDate);
      toDate.value = "${dateTo.day}/${dateTo.month}";
    }
    controllerCode.text = searchRequest.code;
    controllerStaffCode.text = searchRequest.staffCode;
  }

  void setProvince(String value){
    searchRequest.province = value;
    update();
  }

  void setStaffCode(String value){
    searchRequest.staffCode = value;
    update();
  }

  void setToDate(DateTime picked) {
    // print("Date: "+picked.toString());
    toDate.value = "${picked.day}/${picked.month}";
    searchRequest.toDate = picked.toIso8601String();
    update();
  }

  void setFromDate(DateTime picked) {
    // print("Date: "+picked.toString());
    // print("Date: "+picked.toIso8601String());
    fromDate.value = "${picked.day}/${picked.month}";
    searchRequest.fromDate = picked.toIso8601String();
    // DateTime pi = DateTime.parse(picked.toIso8601String());
    update();
  }

  void setStatus(String value){
    searchRequest.status = value;
    update();
  }

  void setService(String value){
    searchRequest.service = value;
    update();
  }

  void setRequestCode(String value){
    searchRequest.code = value;
    update();
  }

  bool checkValidate(){
    // if(currentService.isEmpty){
    //   return false;
    // }
    // if(currentService.isEmpty){
    //   return false;
    // }
    return true;
  }

  void getListProvince(Function(bool isSuccess) function) async{
    ApiUtil.getInstance()!.get(
        url: ApiEndPoints.API_PROVINCES,
        onSuccess: (response) {
          if (response.isSuccess) {
            print("success");
            listProvince = (response.data['data'] as List)
                .map((postJson) => AddressModel.fromJson(postJson))
                .toList();
            if(listProvince.isNotEmpty){
              update();
            }
          } else {
            print("error: ${response.status}");
          }
          function.call(false);

        },
        onError: (error) {
          function.call(false);
        });
  }
}
