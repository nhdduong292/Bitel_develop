import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AfterSaleSearchLogic extends GetxController with SingleGetTickerProviderMixin{
    var isTabOne = true.obs;
    var isTabTwo = false.obs;
    TabController? tabController;
    int index = 0;
    String title;
    BuildContext context;

    AfterSaleSearchLogic(this.title, this.context);

  @override
    void onInit() {
        // TODO: implement onInit
        tabController = TabController(vsync: this, length: 2);
        super.onInit();
        // tabController!.animateTo(index, duration: Duration(milliseconds: 500));
        tabController!.addListener(() {
            // index = tabController!.index;
            // update();
            // print("Position: ${tabController!.index}");
            // ListRequestTabLogic listRequestTabLogic = Get.find<ListRequestTabLogic>();
            // String status = getStatus(tabController!.index);
            // print("Status: $status");
            // listRequestTabLogic.getListRequest(status);
        },);
    }

    void nextPage(int value){
        index = value;
        tabController!.animateTo(index, duration: Duration(milliseconds: 500));
        update();
    }
}