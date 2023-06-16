import 'dart:async';

import 'package:bitel_ventas/main/networks/api_util.dart';
import 'package:bitel_ventas/main/networks/request/search_request.dart';
import 'package:bitel_ventas/main/networks/response/list_request_response.dart';
import 'package:bitel_ventas/main/ui/main/drawer/ftth/sale/sale_logic.dart';
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
  String actionType = '';
  Timer? _debounce;
  GlobalKey<ListRequestTabState> globalKeyCreateRequest = GlobalKey();
  GlobalKey<ListRequestTabState> globalKeySucceedSurvey = GlobalKey();
  GlobalKey<ListRequestTabState> globalKeyDeploying = GlobalKey();
  GlobalKey<ListRequestTabState> globalKeyWaitingRecovery = GlobalKey();
  GlobalKey<ListRequestTabState> globalKeyWaitingChangePlan = GlobalKey();
  GlobalKey<ListRequestTabState> globalKeyWaitingTransfer = GlobalKey();
  GlobalKey<ListRequestTabState> globalKeyComplete = GlobalKey();
  GlobalKey<ListRequestTabState> globalKeyCancel = GlobalKey();
  GlobalKey<ListRequestTabState> globalKeyAll = GlobalKey();

  String keySearch = '';
  int currentTotal = 0;
  int total = 0;
  String currentToDate = '';
  String currentFromDate = '';
  SaleLogic saleLogic = Get.find();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(vsync: this, length: 9);
    index = Get.arguments;
    currentFromDate = saleLogic.fromDate;
    currentToDate = saleLogic.toDate;
    tabController!.animateTo(index, duration: Duration(milliseconds: 500));
    tabController!.addListener(
      () {
        print("Position: ${tabController!.index}");
        index = tabController!.index;
        update();
        // ListRequestTabLogic listRequestTabLogic = Get.find<ListRequestTabLogic>();
        // String status = getStatus(tabController!.index);
        // print("Status: $status");
        // listRequestTabLogic.getListRequest(status);
      },
    );
  }

  void refreshListRequest() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (index == 1) {
        globalKeyCreateRequest.currentState!.getListRequest(keySearch);
      } else if (index == 2) {
        globalKeySucceedSurvey.currentState!.getListRequest(keySearch);
      } else if (index == 3) {
        globalKeyDeploying.currentState!.getListRequest(keySearch);
      } else if (index == 4) {
        globalKeyComplete.currentState!.getListRequest(keySearch);
      } else if (index == 5) {
        globalKeyWaitingRecovery.currentState!.getListRequest(keySearch);
      } else if (index == 6) {
        globalKeyWaitingChangePlan.currentState!.getListRequest(keySearch);
      } else if (index == 7) {
        globalKeyWaitingTransfer.currentState!.getListRequest(keySearch);
      } else if (index == 8) {
        globalKeyCancel.currentState!.getListRequest(keySearch);
      } else if (index == 0) {
        globalKeyAll.currentState!.getListRequest(keySearch);
      }
    });
  }

  String getStatus(int index) {
    if (index == 0) {
      return RequestStatus.CREATE_REQUEST;
    } else if (index == 1) {
      return RequestStatus.SUCCEED_SURVEY;
    } else if (index == 2) {
      return RequestStatus.DEPLOYING;
    } else if (index == 3) {
      return RequestStatus.RECOVERING;
    } else if (index == 4) {
      return RequestStatus.WAITING_CHANGE_PLAN;
    } else if (index == 5) {
      return RequestStatus.WAITING_TRANSFER;
    } else if (index == 6) {
      return RequestStatus.COMPLETE;
    } else if (index == 7) {
      return RequestStatus.CANCEL;
    }
    return "";
  }

  // String getStatus(int index) {
  //   if (index == 0) {
  //     return RequestStatus.CREATE_REQUEST;
  //   } else if (index == 1) {
  //     return RequestStatus.CREATE_REQUEST_WITHOUT_SURVEY;
  //   } else if (index == 2) {
  //     return RequestStatus.SURVEY_OFFLINE_SUCCESSFULLY;
  //   } else if (index == 3) {
  //     return RequestStatus.CONNECTED;
  //   } else if (index == 4) {
  //     return RequestStatus.DEPLOYING;
  //   } else if (index == 5) {
  //     return RequestStatus.COMPLETE;
  //   } else if (index == 6) {
  //     return RequestStatus.CANCEL;
  //   }
  //   return "";
  // }

  void updateSearchRequestToIndex(int index) {
    index = index;
    tabController!
        .animateTo(index, duration: const Duration(milliseconds: 500));
    update();
  }

  void updateSearchRequest(SearchRequest model, BuildContext context) {
    index = model.getPositionStatus(context);
    tabController!
        .animateTo(index, duration: const Duration(milliseconds: 500));
    searchRequest = model;
    currentFromDate = model.fromDate;
    currentToDate = model.toDate;
    update();
  }

  void onSearchChanged(String key) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      // do something with query
      if (index == 1) {
        globalKeyCreateRequest.currentState!.getListRequest(key);
      } else if (index == 2) {
        globalKeySucceedSurvey.currentState!.getListRequest(key);
      } else if (index == 3) {
        globalKeyDeploying.currentState!.getListRequest(key);
      } else if (index == 4) {
        globalKeyWaitingRecovery.currentState!.getListRequest(key);
      } else if (index == 4) {
        globalKeyWaitingChangePlan.currentState!.getListRequest(key);
      } else if (index == 4) {
        globalKeyWaitingTransfer.currentState!.getListRequest(key);
      } else if (index == 5) {
        globalKeyComplete.currentState!.getListRequest(key);
      } else if (index == 6) {
        globalKeyCancel.currentState!.getListRequest(key);
      } else if (index == 0) {
        globalKeyAll.currentState!.getListRequest(key);
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
