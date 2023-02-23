import 'package:bitel_ventas/main/networks/api_util.dart';
import 'package:bitel_ventas/main/networks/response/list_request_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListRequestLogic extends GetxController with SingleGetTickerProviderMixin{
  TabController? tabController;
  String currentService ="";
  String currentCode = "";
  String currentStatus = "";
  String currentProvince ="";
  String currentStaffCode = "";
  String currentFromDate = "";
  String currentToDate = "";
  @override
  void onInit() {
    // TODO: implement onInit
    tabController = TabController(vsync: this, length: 6);
    super.onInit();
    tabController!.addListener(() {
      print("object");
    },);
  }

  void setValueSearch(String service, String code, String status, String province, String staffCode, String fromDate, String toDate){
    currentService = service;
    currentCode = code;
    currentStatus = status;
    currentProvince = province;
    currentStaffCode = staffCode;
    currentFromDate = fromDate;
    currentToDate = toDate;
    update();
  }


}