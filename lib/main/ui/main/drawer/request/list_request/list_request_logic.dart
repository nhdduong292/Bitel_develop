import 'package:bitel_ventas/main/networks/api_util.dart';
import 'package:bitel_ventas/main/networks/request/search_request.dart';
import 'package:bitel_ventas/main/networks/response/list_request_response.dart';
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
    },);
  }

  void updateSearchRequest(SearchRequest model){
    index = model.getPositionStatus();
    tabController!.animateTo(index, duration: Duration(milliseconds: 500));
    searchRequest = model;
    update();
  }

}