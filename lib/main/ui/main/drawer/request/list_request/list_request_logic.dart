import 'dart:async';

import 'package:bitel_ventas/main/networks/api_util.dart';
import 'package:bitel_ventas/main/networks/request/search_request.dart';
import 'package:bitel_ventas/main/networks/response/list_request_response.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/list_request/tab_one/list_request_tab_logic.dart';
import 'package:bitel_ventas/main/ui/main/drawer/request/list_request/tab_one/list_request_tab_page.dart';
import 'package:bitel_ventas/main/utils/values.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListRequestLogic extends GetxController
    with SingleGetTickerProviderMixin {
  TabController? tabController;
  SearchRequest searchRequest = SearchRequest();
  int index = 0;
  Timer? _debounce;
  GlobalKey<ListRequestTabState> globalKey1 = GlobalKey();
  GlobalKey<ListRequestTabState> globalKey2 = GlobalKey();
  GlobalKey<ListRequestTabState> globalKey3 = GlobalKey();
  GlobalKey<ListRequestTabState> globalKey4 = GlobalKey();
  GlobalKey<ListRequestTabState> globalKey5 = GlobalKey();
  GlobalKey<ListRequestTabState> globalKey6 = GlobalKey();
  GlobalKey<ListRequestTabState> globalKey7 = GlobalKey();

  String keySearch = '';
  @override
  void onInit() {
    // TODO: implement onInit
    tabController = TabController(vsync: this, length: 7);
    super.onInit();
    index = Get.arguments;
    tabController!.animateTo(index, duration: Duration(milliseconds: 500));
    tabController!.addListener(
      () {
        index = tabController!.index;
        update();
        // print("Position: ${tabController!.index}");
        // ListRequestTabLogic listRequestTabLogic = Get.find<ListRequestTabLogic>();
        // String status = getStatus(tabController!.index);
        // print("Status: $status");
        // listRequestTabLogic.getListRequest(status);
      },
    );
  }

  String getStatus(int index) {
    if (index == 0) {
      return RequestStatus.CREATE_REQUEST;
    } else if (index == 1) {
      return RequestStatus.CREATE_REQUEST_WITHOUT_SURVEY;
    } else if (index == 2) {
      return RequestStatus.SURVEY_OFFLINE_SUCCESSFULLY;
    } else if (index == 3) {
      return RequestStatus.CONNECTED;
    } else if (index == 4) {
      return RequestStatus.DEPLOYING;
    } else if (index == 5) {
      return RequestStatus.COMPLETE;
    } else if (index == 6) {
      return RequestStatus.CANCEL;
    }
    return "";
  }

  void updateSearchRequest(SearchRequest model, BuildContext context) {
    index = model.getPositionStatus(context);
    tabController!.animateTo(index, duration: Duration(milliseconds: 500));
    searchRequest = model;
    update();
  }

  void onSearchChanged(String key) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      // do something with query
      if (index == 0) {
        globalKey1.currentState!.getListRequest(key);
      } else if (index == 1) {
        globalKey2.currentState!.getListRequest(key);
      } else if (index == 2) {
        globalKey3.currentState!.getListRequest(key);
      } else if (index == 3) {
        globalKey4.currentState!.getListRequest(key);
      } else if (index == 4) {
        globalKey5.currentState!.getListRequest(key);
      } else if (index == 5) {
        globalKey6.currentState!.getListRequest(key);
      } else if (index == 6) {
        globalKey7.currentState!.getListRequest(key);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _debounce?.cancel();
    super.dispose();
  }
}
