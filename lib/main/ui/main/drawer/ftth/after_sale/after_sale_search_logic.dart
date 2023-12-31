import 'package:bitel_ventas/main/networks/model/find_account_model.dart';
import 'package:bitel_ventas/main/utils/values.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AfterSaleSearchLogic extends GetxController
    with SingleGetTickerProviderMixin {
  var isTabOne = true.obs;
  var isTabTwo = false.obs;
  TabController? tabController;
  int index = 0;
  String title;
  String type;
  List<FindAccountModel> listAccount = [];
  BuildContext context;

  int fingerId = 0;

  AfterSaleSearchLogic(this.title, this.context, this.type);

  @override
  void onInit() {
    // TODO: implement onInit
    if (type == AfterSaleStatus.CHANGE_PLAN ||
        type == AfterSaleStatus.CANCEL_SERVICE ||
        type == AfterSaleStatus.TRANSFER_SERVICE) {
      var data = Get.arguments;
      fingerId = data[0];
    }

    tabController = TabController(vsync: this, length: 2);
    super.onInit();
    // tabController!.animateTo(index, duration: Duration(milliseconds: 500));
    tabController!.addListener(
      () {
        // index = tabController!.index;
        // update();
        // print("Position: ${tabController!.index}");
        // ListRequestTabLogic listRequestTabLogic = Get.find<ListRequestTabLogic>();
        // String status = getStatus(tabController!.index);
        // print("Status: $status");
        // listRequestTabLogic.getListRequest(status);
      },
    );
  }

  void nextPage(int value) {
    index = value;
    tabController!.animateTo(index, duration: Duration(milliseconds: 500));
    update();
  }

  Future<bool> onWillPop() async {
    if (index == 0) {
      Get.back();
    } else {
      isTabTwo.value = false;
      isTabOne.value = true;
      nextPage(0);
    }
    return false; //<-- SEE HERE
  }
}
