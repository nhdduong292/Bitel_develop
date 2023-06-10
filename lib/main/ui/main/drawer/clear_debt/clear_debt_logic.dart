import 'package:bitel_ventas/main/networks/model/clear_debt_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClearDebtLogic extends GetxController with SingleGetTickerProviderMixin {
  late BuildContext context;
  var isTabOne = true.obs;
  var isTabTwo = false.obs;
  var isTabThree = false.obs;
  TabController? tabController;
  int index = 0;

  double balance = 0.0;
  List<ClearDebtModel> listClearDebt = [];
  ClearDebtModel clearDebtModel = ClearDebtModel();
  double totalService = 0;

  ClearDebtLogic({required this.context});

  @override
  void onInit() {
    // TODO: implement onInit
    tabController = TabController(vsync: this, length: 3);
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

  void setListClearDebt(List<ClearDebtModel> list) {
    listClearDebt.clear();
    listClearDebt = list;
  }

  void setClearDebtSelect(
      {required ClearDebtModel model, required double total}) {
    clearDebtModel = model;
    totalService = total;
  }

  void nextPage(int value) {
    index = value;
    tabController!
        .animateTo(index, duration: const Duration(milliseconds: 500));
    update();
  }
}
