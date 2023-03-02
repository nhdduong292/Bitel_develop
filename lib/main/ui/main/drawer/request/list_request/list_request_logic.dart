import 'package:bitel_ventas/main/networks/api_util.dart';
import 'package:bitel_ventas/main/networks/request/search_request.dart';
import 'package:bitel_ventas/main/networks/response/list_request_response.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/list_request/tab_one/list_request_tab_logic.dart';
import 'package:bitel_ventas/main/utils/values.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListRequestLogic extends GetxController with SingleGetTickerProviderMixin{
  TabController? tabController;
  SearchRequest searchRequest = SearchRequest();
  int index = 0;
  @override
  void onInit() {
    // TODO: implement onInit
    tabController = TabController(vsync: this, length: 6);
    super.onInit();
    tabController!.addListener(() {
      print("Position: ${tabController!.index}");
      // ListRequestTabLogic listRequestTabLogic = Get.find<ListRequestTabLogic>();
      String status = getStatus(tabController!.index);
      print("Status: $status");
      // listRequestTabLogic.getListRequest(status);
    },);
  }

  String getStatus(int index){
    if(index == 0) {
      return RequestStatus.CREATE_REQUEST;
    } else if(index == 1){
      return RequestStatus.CREATE_REQUEST_WITHOUT_SURVEY;
    }
    else if(index == 2){
      return RequestStatus.CONNECTED;
    }
    else if(index == 3){
      return RequestStatus.DEPLOYING;
    }
    else if(index == 4){
      return RequestStatus.COMPLETE;
    }
    else if(index == 5){
      return RequestStatus.CANCEL;
    }
    return"";
  }

  void updateSearchRequest(SearchRequest model){
    index = model.getPositionStatus();
    tabController!.animateTo(index, duration: Duration(milliseconds: 500));
    searchRequest = model;
    update();
  }

}